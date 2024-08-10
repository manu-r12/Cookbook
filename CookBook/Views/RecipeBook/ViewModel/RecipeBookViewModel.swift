//
//  RecipeBookViewModel.swift
//  CookBook
//
//  Created by Manu on 2024-07-16.
//

import Foundation
import FirebaseAuth
import Firebase


struct RecipeItems: Codable{
    let recipesArray: [RecipeModel]
}


class RecipeBookViewModel: ObservableObject {
    
    
    let db = Firestore.firestore()
    
    @Published var recipeItems: [RecipeModel]?
    @Published var isFetchingRecipes: Bool = false
    @Published var user: UserModel?
    

    

    
    
    init(){
        Task{
            await fetchRecipeItems()
            await fetchUserDetails()
        }
    }
    
    @MainActor
    func fetchUserDetails() async {
        
        guard let user = Auth.auth().currentUser else {
            print("Found No Current User Darling ")
            return
        }
        
        let docRef = db.collection("users").document(user.uid)
        
        do {
            print("Fetching User Details....")
            let res = try await docRef.getDocument()
            let data = try res.data(as: UserModel.self)
            self.user = data
             
            print("Got the registerd user data", data)

            
        }catch{
            print("Oops error in fetching User Details", error.localizedDescription)

        }
        
    }
    
    
    func refreshData() async {
        await fetchRecipeItems()
    }
    
    
    
    
    
    @MainActor
    func fetchRecipeItems() async  {
        
        
        
        guard let user = Auth.auth().currentUser else {
            print("Found No Current User Darling ")
            return
        }

        
        let docRef = db.collection("recipes").document(user.uid)
        
        
        do {
            isFetchingRecipes = true
            let res = try await docRef.getDocument()
            let data = try res.data(as: RecipeItems.self)
            recipeItems = data.recipesArray
            isFetchingRecipes = false
        }catch{
            print("Oops error in fetching ", error.localizedDescription)
            isFetchingRecipes = false
        }
        
    }
    
    
    
    
}



