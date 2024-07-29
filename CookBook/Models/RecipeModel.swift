
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
