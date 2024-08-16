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


//enum PreparationMinutes: Codable {
//    case int(Int)
//    case string(String)
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let intValue = try? container.decode(Int.self) {
//            self = .int(intValue)
//            return
//        }
//        if let stringValue = try? container.decode(String.self) {
//            self = .string(stringValue)
//            return
//        }
//        throw DecodingError.typeMismatch(PreparationMinutes.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected Int or String"))
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        switch self {
//        case .int(let intValue):
//            try container.encode(intValue)
//        case .string(let stringValue):
//            try container.encode(stringValue)
//        }
//    }
//}




class IngredientsFinderOptionsViewModel: ObservableObject {
    
    @Published var fetchedResultData: FetchedItem?
    @Published var isFetchingData: Bool = false
    let apiManager = APIManager(urlSession: .init(configuration: .default))

    
    @MainActor
    func startFetching(query: String,
                       searchMethod: SearchMethods) async {
        isFetchingData = true
        // Handling the case
        do {
            print("Started Fetching.....")
            fetchedResultData = try await fetchRecipesInfo(
                query: query,
                numberOfRes: 20,
                searchMethod: searchMethod
                )
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
                                 searchMethod: SearchMethods) async throws -> FetchedItem
    
    {
        guard let apiKey = ConfigLoader.loadConfig()?.SpoonacularAPIKey else {
            print("from apikey")
            throw URLError(.badURL)
            
        }
        
        print("from urlComponents")

        guard var urlComponents = URLComponents(
            string: API_ENDPOINTS.GET_RECIPE_INFO
                .url) else {
            print("from urlComponents")
            throw URLError(.badURL)
            
        }
        var urlQueryItems: [URLQueryItem]
        
        //How we wanna search
        if searchMethod == .SearchByName {
            urlQueryItems = [
                URLQueryItem(name: "apiKey", value: apiKey),
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "number", value: "\(numberOfRes)"),
                URLQueryItem(name: "addRecipeInformation", value: "true"),
                URLQueryItem(name: "titleMatch", value: query),
                URLQueryItem(name: "instructionsRequired", value: "true")	
                
            ]
            
        }else{
            urlQueryItems = [
                URLQueryItem(name: "apiKey", value: apiKey),
                URLQueryItem(name: "titleMatch", value: query),
                URLQueryItem(name: "number", value: "\(numberOfRes)"),
                
                
            ]
        }
        
        
        urlComponents.queryItems = urlQueryItems
        
        print("from url")

        guard let url = urlComponents.url else {

            throw URLError(.badURL)
            
        }
        
        let (data, res) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200  else {
            print("from httpResponse")

            throw URLError(.badServerResponse)
            
        }
        
        let fetchedRecipeData = try JSONDecoder().decode(FetchedItem.self, from: data )
        
        return fetchedRecipeData
    }
    
}
