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

// i dont know what the hell this do? may be can use it in the future :)
enum PreparationMinutes: Codable {
    case int(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
            return
        }
        if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
            return
        }
        throw DecodingError.typeMismatch(PreparationMinutes.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected Int or String"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let intValue):
            try container.encode(intValue)
        case .string(let stringValue):
            try container.encode(stringValue)
        }
    }
}

struct FetchedRecipe: Codable, Identifiable, Hashable{
    let id: Int
    let title: String
    let image: String
    let dishTypes: [String]
    let servings: Int
    let readyInMinutes: Int
    let summary: String


}


class IngredientsFinderOptionsViewModel: ObservableObject {
    
    
    @Published var fetchedResultData: FetchedItem?
    @Published var isFetchingData: Bool = false
    
    let apiManager = APIManager()
    
    
    
    
    @MainActor
    func startFetching(query: String,
                       searchMethod: SearchMethods) async {
        isFetchingData = true
        // Handling the case
        do {
            print("Started Fetching.....")
            fetchedResultData = try await apiManager.fetchRecipesInfo(
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
    
  
    
}
