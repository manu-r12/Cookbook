//
//  RecipeBookViewModel.swift
//  CookBook
//
//  Created by Manu on 2024-07-16.
//

import Foundation
import FirebaseAuth
import Firebase


class RecipeBookViewModel: ObservableObject {
    
    
    let db = Firestore.firestore()
    
    @Published var recipeItems: [RecipeModel]?
    @Published var isFetchingRecipes: Bool = false



    init(){
        Task{
            await fetchRecipeItems()
        }
    }
    
    
    
    
    func fetchRecipeItems() async  {
        
        

        guard let user = Auth.auth().currentUser else {
            print("Found No Current User Darling ")
            return
        }
        
        
        let docRef = db.collection("recipes").document(user.uid)
        
        
        do {
            print("Fetching")
            let recipeItems = try await docRef.getDocument(as: RecipeModel.self)
            print("Here si the fetched data ", recipeItems)
        }catch{
            print("Oops error in fetching ", error.localizedDescription)
        }
   
            
            
        }
        
        
        
        
    }
    
    

