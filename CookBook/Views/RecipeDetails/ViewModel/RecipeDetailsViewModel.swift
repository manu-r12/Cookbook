//
//  RecipeDetailsVIewModel.swift
//  CookBook
//
//  Created by Manu on 2024-08-07.
//

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
    
    
    
    @MainActor
    func getIngredientByRecipeId(id: Int) async {
        do{
            isIngredientsFetching = true
            let data = try await apiManager.fetchIngredientsByRecipeId(id: id)
            ingredients = data
            isIngredientsFetching = false
        }catch{
            isIngredientsFetching = false
            print(
                "Error in fetching ingredients by a recipe id - \(error.localizedDescription)"
            )
        }
    }
    
    @MainActor
    func getRecipeInstrucions(id : Int) async {
        do{
            isInstructionsFetching = true
            let data = try await apiManager.fetchInstructionsForARecipe(id: id)
            instructions = data ?? []
            isInstructionsFetching = false
        }catch{
            isInstructionsFetching = false
            print(
                "Error in fetching Instuctions by a recipe id - \(error.localizedDescription)"
            )
        }
    }
    
    
    @MainActor
    func getRecipeById(id: Int) async {
        do{
            isRecipeFetching = true
            let data = try await apiManager.fetchRecipeById(id: id)
            fetchedRecipeDataById = data
            isRecipeFetching = false
        }catch{
            isRecipeFetching = false
            print(
                "Error in fetching recipe data by a recipe id - \(error.localizedDescription)"
            )
        }
    }
    
    
    
    
    
    func uploadBookmarkedRecipe(recipe: FetchedRecipe) async {
        guard let user = AuthenticationManager.shared.userSession else {
            print("Could not get the user session data")
            return
        }
        
        let db = Firestore.firestore()
        
        // Encode the recipe
        guard let encodedRecipeData = try? Firestore.Encoder().encode(recipe) else {
            print("Failed to encode recipe data")
            return
        }
        
        let ref = db.collection("bookmarks").document(user.uid)
        
        do {
            // Check if the document exists
            let document = try await ref.getDocument()
            if document.exists {
                // If the document exists, update it
                try await ref.updateData([
                    "recipes": FieldValue.arrayUnion([encodedRecipeData])
                ])
            } else {
                // If the document doesn't exist, create it
                try await ref.setData([
                    "recipes": [encodedRecipeData]
                ])
            }
            print("Recipe successfully uploaded!")
        } catch {
            print("Failed to upload recipe: \(error)")
        }
    }
    
    
    //TODO: make a function to retrieve all the user created recips
    
    func getUserCreatedRecipes() {
        
    }
}
