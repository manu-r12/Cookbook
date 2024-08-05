//
//  IngredientsFInderOptionsViewModel.swift
//  CookBook
//
//  Created by Manu on 2024-08-02.
//

import Foundation



struct FetchedItem: Codable{
    let results: [FetchedRecipe]
}

enum APIENDPOINTS: String, CaseIterable {
    case GET_RECIPE_INFO = "https://api.spoonacular.com/recipes/complexSearch"
}

struct FetchedRecipe: Codable, Identifiable, Hashable{
    let id: Int
    let title: String
    
    
}


class IngredientsFInderOptionsViewModel: Identifiable, ObservableObject {
    
    @Published var fetchedResultData: FetchedItem?
    @Published var isFetchingData: Bool = false
    
    
    @MainActor
    func startFetching(query: String,
                       searchMethod: SearchMethod) async {
        isFetchingData = true
        // Handling the case
        do {
            print("Started Fetching.....")
            fetchedResultData = try await fetchRecipesInfo(
                query: query,
                numberOfRes: 20,
                searchMethod: searchMethod
                )
            print("========== Fetching Done ==========")
            print("\(fetchedResultData)")
            isFetchingData = false
        }catch{
            print(
                "Error in fetching from (fetchRecipesInfo()) - \(error.localizedDescription)"
            )
            isFetchingData = false
        }
  
    }
    
    func fetchRecipesInfo(query: String,
                                 numberOfRes: Int,
                                 searchMethod: SearchMethod) async throws -> FetchedItem
    
    {
        guard let apiKey = ConfigLoader.loadConfig()?.SpoonacularAPIKey else {
            throw URLError(.badURL)
        }
        
        guard var urlComponents = URLComponents(
            string: APIENDPOINTS.GET_RECIPE_INFO
                .rawValue) else {
            throw URLError(.badURL)
            
        }
        var urlQueryItems: [URLQueryItem]
        
        //How we wanna search
        if searchMethod == .SearchByName {
            urlQueryItems = [
                URLQueryItem(name: "apiKey", value: apiKey),
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "number", value: "\(numberOfRes)"),
                URLQueryItem(name: "addRecipeInformation", value: "True"),
                URLQueryItem(name: "titleMatch", value: query),
//                URLQueryItem(name: "instructionsRequired", value: "true")	
                
            ]
            
        }else{
            urlQueryItems = [
                URLQueryItem(name: "apiKey", value: apiKey),
                URLQueryItem(name: "titleMatch", value: query),
                URLQueryItem(name: "number", value: "\(numberOfRes)"),
                
                
            ]
        }
        
        
        urlComponents.queryItems = urlQueryItems
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, res) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200  else {
            throw URLError(.badServerResponse)
            
        }
        
        let fetchedRecipeData = try JSONDecoder().decode(
            FetchedItem.self,
            from: data
        )
        
        return fetchedRecipeData
    }
    
}
