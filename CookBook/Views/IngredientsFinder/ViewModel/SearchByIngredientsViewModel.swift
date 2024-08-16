//
//  SearchByIngredientsViewModel.swift
//  CookBook
//
//  Created by Manu on 2024-08-16.
//

import Foundation


class SearchByIngredientsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var recipeData: [FetchedRecipeByIngredients]?
    
    let apiManager = APIManager(urlSession: .init(configuration: .default))
    
    
    
    @MainActor
    func fetchRecipe(with ingredients: String) async {
        
        do{
            print("Fetching Recipe By Ingredients_______________")
            isLoading = true
            let res = try await apiManager.fetchRecipeByIngredients(
                ingredients: ingredients
            )
            
            recipeData = res
            isLoading = false
            
            print("*********************************************************** Got the data ***********************************************************")
            print("Data ==> \(res ?? [])")

            
        }catch{
            isLoading = false

            print(
                "Error in fetching Recipe By Ingredients \(error.localizedDescription)"
            )
        }
        
    }

    
    
}
