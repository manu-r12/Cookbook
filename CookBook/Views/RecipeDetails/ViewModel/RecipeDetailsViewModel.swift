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
    
//    func getUserCreatedRecipes(documentID: String, recipeID: Int) async throws -> Recipe? {
          // the document is same as userid means it is userID
//        let docRef = db.collection("recipes").document(documentID)
//        
//        do {
//            let document = try await docRef.getDocument()
//            guard let recipeDocument = try document.data(as: RecipeDocumentModel.self) else {
//                print("Document not found or failed to decode.")
//                return nil
//            }
//            
//            return recipeDocument.recipes.first(where: { $0.id == recipeID }) ?? {
//                print("No such recipe found in the document.")
//                return nil
//            }()
//            
//        } catch {
//            print("Error fetching document: \(error)")
//            throw error
//        }
//    }
}
