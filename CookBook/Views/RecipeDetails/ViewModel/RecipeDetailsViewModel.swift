

import Foundation
import OSLog
import Firebase


enum BookmarkMethod {
    case SearchedRecipe
    case UserCreated
}


enum DeleteRecipeMethod {
    case FromRecipeBook
    case FromeBookmark
}


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
    
    //MARK: Get the ingredients by the recipe Id
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
    
    //MARK: Get the instructions by the recipe Id
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
    
    //MARK: Get the whole recipe by id
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
    
    //MARK: Bookmark the recipe
     func uploadBookmarkedRecipe<T: Codable>(recipe: T, _ bookmarkMethod: BookmarkMethod) async {
        guard let user = AuthenticationManager.shared.userSession else {
            print("User session not available")
            return
        }
        
        guard let encodedRecipeData = try? Firestore.Encoder().encode(recipe) else {
            print("Failed to encode recipe data")
            return
        } 
        
        let ref = db.collection("bookmarks").document(user.uid)
        
        
        switch bookmarkMethod {
        case .SearchedRecipe:
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
        case .UserCreated:
            do {
                let document = try await ref.getDocument()
                if document.exists {
                    try await ref.updateData([
                        "userCreatedRecipes": FieldValue.arrayUnion([encodedRecipeData])
                    ])
                } else {
                    try await ref.setData([
                        "userCreatedRecipes": [encodedRecipeData]
                    ])
                }
                print("Recipe successfully uploaded!")
            } catch {
                print("Failed to upload recipe: \(error)")
            }
        }
        
     
    }
    
    
    //MARK: Get the user created recipes by the document id(i used user id for this)
    func getUserCreatedRecipes(recipeID: UUID) async throws -> RecipeModel? {
        
        guard let userId = AuthenticationManager.shared.userSession?.uid else {
            print("User session not available")
            return nil
        }

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
    
    
    private func deleteRecipeItemFromBookmark(recipeID: UUID) async throws {
        
    }
    
    
    
    private func deleteRecipeItem(recipeID: UUID) async throws {
        guard let user = user else {
            print("User session not available")
            return
        }
        
        let documentRef = db.collection("recipes").document(user.uid)
        
        do {

            let document = try await documentRef.getDocument()
            
            if let data = document.data(), let recipesData = data["recipesArray"] as? [[String: Any]] {

                let decoder = JSONDecoder()
                let recipes = try recipesData.map { dict -> RecipeModel in
                    let jsonData = try JSONSerialization.data(withJSONObject: dict)
                    return try decoder.decode(RecipeModel.self, from: jsonData)
                }
                

                if let recipeToRemove = recipes.first(where: { $0.id == recipeID }) {

                    let encoder = JSONEncoder()
                    let recipeToRemoveData = try JSONSerialization.jsonObject(with: encoder.encode(recipeToRemove))
                    
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
    
    func deleteRecipe(id: UUID, from: DeleteRecipeMethod) async {
        do {
            switch from {
            case .FromRecipeBook:
                
                try await deleteRecipeItem(recipeID: id)
                
            case .FromeBookmark:
                print("Nothing Right Now!!")
            }
          
        }catch{
            print(error.localizedDescription)
        }
    }
    

}
