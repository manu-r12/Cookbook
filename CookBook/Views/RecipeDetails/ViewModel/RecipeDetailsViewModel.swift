//
//  RecipeDetailsVIewModel.swift
//  CookBook
//
//  Created by Manu on 2024-08-07.
//

import Foundation
import OSLog

class RecipeDetailsViewModel: ObservableObject {
  
    
    let apiManager = APIManager(urlSession: .init(configuration: .default))
    @Published var isIngredientsFetching: Bool = false
    @Published var isInstructionsFetching: Bool = false
    
    @Published var instructions: [RecipeInstrcutions] = []

    @Published var ingredients: FetchedIngredientsByRecipeID?
    
    @MainActor
    func getIngredientByRecipeId(id: Int) async {
        do{
            isIngredientsFetching = true
            print("Fetching Ingredients.....")
            let data = try await apiManager.fetchIngredientsByRecipeId(id: id)
            ingredients = data
            print("Fetched the data => \(data?.ingredients ?? [])")
            isIngredientsFetching = false
        }catch{
            isIngredientsFetching = false
            print(
                "Error in fetching ingredients by a recipe id - \(error.localizedDescription)"
            )
            Logger().error("Error in fetching ingredients by a recipe id - \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func getRecipeInstrucions(id : Int) async {
        do{
            isInstructionsFetching = true
            print("Fetching Instuctions.....")
            let data = try await apiManager.fetchInstructionsForARecipe(id: id)
            instructions = data ?? []
            print("Fetched the data => \(data ?? [])")
            isInstructionsFetching = false
        }catch{
            isInstructionsFetching = false
            print(
                "Error in fetching Instuctions by a recipe id - \(error.localizedDescription)"
            )
        }
    }
}
