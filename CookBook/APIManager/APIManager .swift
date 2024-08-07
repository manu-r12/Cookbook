//
//  APIManager .swift
//  CookBook
//
//  Created by Manu on 2024-08-07.
//

import Foundation


class APIManager {
    
    
    static func fetchIngredientsByRecipeId(id: Int) async throws -> FetchedIngredientsByRecipeID? {
        
        guard let apiKey = ConfigLoader.loadConfig()?.SpoonacularAPIKey else {
            throw URLError(.badURL)
        }
        
        guard var urlComponents = URLComponents(
            string: APIENDPOINTS
                .GET_INGREDIENTS_BY_RECIPE_ID(id: id).url) else {
            throw URLError(.badURL)
            
        }
        var urlQueryItems: [URLQueryItem]
        
        
        urlQueryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
        ]
        
        
        
        urlComponents.queryItems = urlQueryItems
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, res) = try await URLSession.shared.data(
            from: url
        )
        
        guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200  else {
            throw URLError(.badServerResponse)
            
        }
        
        let fetchedIngredientsData = try JSONDecoder().decode(
            FetchedIngredientsByRecipeID.self,
            from: data
        )
        
        
        return fetchedIngredientsData
    }
}
