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
            print("Could not the get user session data")
            return
        }
        
        guard let encoded_recipeData = try? Firestore.Encoder().encode(recipe) else {return}
        do {
            try await Firestore
                .firestore()
                .collection("bookmarks")
                .document("\(recipe.id)")
                .setData(encoded_recipeData)
            print("Saved the bookmarked recipe successfully✅")
            
        }catch{
            print("Error occured in saving the data", error.localizedDescription)
        }
    }
}
