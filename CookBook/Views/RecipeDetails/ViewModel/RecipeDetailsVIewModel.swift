//
//  RecipeDetailsVIewModel.swift
//  CookBook
//
//  Created by Manu on 2024-08-07.
//

import Foundation
import OSLog

class RecipeDetailsVIewModel: ObservableObject {
    
    
    init(){
        Task{
            await getIngredientByRecipeId()
        }
    }
    
    func getIngredientByRecipeId() async {
        do{
            print("Fetching Ingredients.....")
            let data = try await APIManager.fetchIngredientsByRecipeId(id: 1003464)
            print("Fetched the data => \(data?.ingredients)")
        }catch{
            print(
                "Error in fetching ingredients by a recipe id - \(error.localizedDescription)"
            )
            Logger().error("Error in fetching ingredients by a recipe id - \(error.localizedDescription)")
        }
    }
}
