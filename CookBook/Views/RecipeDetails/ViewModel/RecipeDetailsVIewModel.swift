//
//  RecipeDetailsVIewModel.swift
//  CookBook
//
//  Created by Manu on 2024-08-07.
//

import Foundation
import OSLog

class RecipeDetailsVIewModel: ObservableObject {
    
    let apiManager = APIManager()
    @Published var isLoading: Bool = false
    
    
    init(){
        
        Task{
            isLoading = true
            print("********************************** Processing **********************************")
            await getIngredientByRecipeId()
            await getRecipeInstrucions()
            print("********************************** Processing is done **********************************")
            await MainActor.run {
                isLoading = false

            }

        }
    }
    
    func getIngredientByRecipeId() async {
        do{
            print("Fetching Ingredients.....")
            let data = try await apiManager.fetchIngredientsByRecipeId(id: 1003464)
            print("Fetched the data => \(data?.ingredients ?? [])")
        }catch{
            print(
                "Error in fetching ingredients by a recipe id - \(error.localizedDescription)"
            )
            Logger().error("Error in fetching ingredients by a recipe id - \(error.localizedDescription)")
        }
    }
    
    func getRecipeInstrucions() async {
        do{
            print("Fetching Instuctions.....")
            let data = try await apiManager.fetchInstructionsForARecipe(
                id: 1003464
            )
            print("Fetched the data => \(data ?? [])")
        }catch{
            print(
                "Error in fetching Instuctions by a recipe id - \(error.localizedDescription)"
            )
        }
    }
}
