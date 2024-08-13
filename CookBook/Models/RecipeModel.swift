
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

struct Steps: Codable, Hashable {
    let step: String
}

struct RecipeInstrcutions: Codable, Hashable{
    let steps: [Steps]
    let name: String

}


struct IngredientsAmount: Codable, Hashable {
    let us: USMetric
}

struct USMetric: Codable, Hashable {
    let unit: String
    let value: Float
}

struct FetchedIngredientsInfo: Codable, Hashable {
    let name: String
    let image: String
    let amount: IngredientsAmount
}

struct FetchedIngredientsByRecipeID: Codable, Hashable {
    let ingredients : [FetchedIngredientsInfo]
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


struct FetchedRecipeByIngredients: Codable, Identifiable, Hashable{
    let id: Int
    let title: String
    let image: String
    let missedIngredients: [MissedIngredients]
    let usedIngredients: [UsedIngredients]
    
    func missedIngredientsCount() -> Int {
        missedIngredients.count
    }
    
    func usedIngredientsCount() -> Int {
        usedIngredients.count
    }
}

struct MissedIngredients: Codable, Hashable {
    let name: String
    let image: String
}


struct UsedIngredients: Codable, Hashable {
    let name: String
    let image: String
}
