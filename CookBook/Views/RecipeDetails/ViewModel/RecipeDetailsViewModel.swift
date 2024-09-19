import Foundation
import OSLog
import Firebase

class RecipeDetailsViewModel: ObservableObject {
    
    let apiManager = APIManager(urlSession: .init(configuration: .default))
    @Published var isIngredientsFetching: Bool = false
    @Published var isInstructionsFetching: Bool = false
    @Published var isRecipeFetching: Bool = false
    
    @Published var fetchedRecipeDataById: FetchedRecipe?
    @Published var instructions: [RecipeInstrcutions] = []
    @Published var ingredients: FetchedIngredientsByRecipeID?
    
    private let db = Firestore.firestore()
    let user = AuthenticationManager.shared.userSession
    
    
    @MainActor
    func getIngredientByRecipeId(id: Int) async {
        isIngredientsFetching = true
        defer { isIngredientsFetching = false }  // Ensures flag reset
        do {
            let data = try await apiManager.fetchIngredientsByRecipeId(id: id)
            ingredients = data
        } catch {
            print("Error fetching ingredients by recipe ID: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func getRecipeInstructions(id: Int) async {
        isInstructionsFetching = true
        defer { isInstructionsFetching = false }
        do {
            let data = try await apiManager.fetchInstructionsForARecipe(id: id)
            instructions = data ?? []
        } catch {
            print("Error fetching instructions by recipe ID: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func getRecipeById(id: Int) async {
        isRecipeFetching = true
        defer { isRecipeFetching = false }
        do {
            let data = try await apiManager.fetchRecipeById(id: id)
            fetchedRecipeDataById = data
        } catch {
            print("Error fetching recipe by ID: \(error.localizedDescription)")
        }
    }
    
    func uploadBookmarkedRecipe(recipe: FetchedRecipe) async {
        guard let user = AuthenticationManager.shared.userSession else {
            print("User session not available")
            return
        }
        
        guard let encodedRecipeData = try? Firestore.Encoder().encode(recipe) else {
            print("Failed to encode recipe data")
            return
        }
        
        let ref = db.collection("bookmarks").document(user.uid)
        
        do {
            let document = try await ref.getDocument()
            if document.exists {
                try await ref.updateData([
                    "recipes": FieldValue.arrayUnion([encodedRecipeData])
                ])
            } else {
                try await ref.setData([
                    "recipes": [encodedRecipeData]
                ])
            }
            print("Recipe successfully uploaded!")
        } catch {
            print("Failed to upload recipe: \(error)")
        }
    }
    
    func getUserCreatedRecipes(recipeID: UUID) async throws -> RecipeModel? {
        
        guard let userId = AuthenticationManager.shared.userSession?.uid else {
            print("User session not available")
            return nil
        }
//        for testing purpose
//        let recipeID = UUID(uuidString: "9F89360C-DBCA-4A18-96D4-1E52A8DAB97F")
        let docRef = db.collection("recipes").document(userId)
        
        do {
            let document = try await docRef.getDocument()
            guard let recipeDocument = try? document.data(as: RecipeItems.self) else {
                print("Document not found or failed to decode.")
                return nil
            }
            
            let data = recipeDocument.recipesArray.first(where: { $0.id == recipeID }) ?? {
                print("No such recipe found in the document.")
                return nil
            }()
            
            
            return data
            
        } catch {
            print("Error fetching document: \(error)")
            throw error
        }
    }
    
    
    
    private func deleteRecipeItem(recipeID: UUID) async throws {
        guard let user = user else {
            print("User session not available")
            return
        }
        
        let documentRef = db.collection("recipes").document(user.uid)
        
        do {
            // Fetch the document asynchronously
            let document = try await documentRef.getDocument()
            
            if let data = document.data(), let recipesData = data["recipesArray"] as? [[String: Any]] {
                // Decode the array of dictionaries into RecipeModel objects
                let decoder = JSONDecoder()
                let recipes = try recipesData.map { dict -> RecipeModel in
                    let jsonData = try JSONSerialization.data(withJSONObject: dict)
                    return try decoder.decode(RecipeModel.self, from: jsonData)
                }
                
                // Find the recipe by recipeID
                if let recipeToRemove = recipes.first(where: { $0.id == recipeID }) {
                    // Convert recipeToRemove back to a dictionary for Firestore
                    let encoder = JSONEncoder()
                    let recipeToRemoveData = try JSONSerialization.jsonObject(with: encoder.encode(recipeToRemove))
                    
                    // Update Firestore to remove the recipe
                    try await documentRef.updateData([
                        "recipesArray": FieldValue.arrayRemove([recipeToRemoveData])
                    ])
                    
                    print("Recipe successfully removed!")
                } else {
                    print("Recipe with the given recipeId not found.")
                }
            }
        } catch {
            print("Error fetching or updating document: \(error.localizedDescription)")
        }
    }
    
    func deleteRecipe(id: UUID) async {
        do {
            try await deleteRecipeItem(recipeID: id)
        }catch{
            print(error.localizedDescription)
        }
    }
    

}
