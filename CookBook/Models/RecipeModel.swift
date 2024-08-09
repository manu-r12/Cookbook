
import Foundation



struct Ingredients: Codable, Hashable{
    let quantity: String
    let nameOfIngredient: String
}

struct RecipeModel: Codable, Identifiable, Hashable {
    
    let id: UUID
    let name: String
    let imageUrl: String
    let ingredients: [Ingredients]
    let instructions: String
    let category: [String]
    let preprationTime: String
    let cookingTime: String
    
}

struct Steps: Codable {
    let step: String
}

struct RecipeInstrcutions: Codable{
    let steps: [Steps]
    let name: String

}


struct IngredientsAmount: Codable {
    let us: USMetric
}

struct USMetric: Codable {
    let unit: String
    let value: Float
}

struct FetchedIngredientsInfo: Codable {
    let name: String
    let image: String
    let amount: IngredientsAmount
}

struct FetchedIngredientsByRecipeID: Codable {
    let ingredients : [FetchedIngredientsInfo]
}
