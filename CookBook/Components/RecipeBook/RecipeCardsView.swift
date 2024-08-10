//
//  RecipeCardsView.swift
//  CookBook
//
//  Created by Manu on 2024-07-26.
//

import SwiftUI

struct RecipeCardsView: View {
    @ObservedObject var vm: RecipeBookViewModel
    @State var selectedCatg: Category = .all
    
    var body: some View {
        if !vm.isFetchingRecipes{
            if let recipeData = vm.recipeItems {
                VStack{
                    VStack{
                        VStack(alignment: .leading){
                            Text("Your Recipies")
                                .font(.custom("Poppins-Medium", size: 19))
                                .padding(.horizontal,20)
                            CategoriesView(selectedCatg: $selectedCatg)
                            
                        }
                    }
                    
                    
                    VStack{
                        
                        VStack(alignment: .leading,spacing: 25){
                            RecipeBookCard(
                                recipeData: recipeData,
                                category: selectedCatg
                            )
                        }
                        .padding()
                    }
                }
            }
        }else{
            VStack {
                Text("Loading...")
                ProgressView()
            }
            .padding(.top, 150)
        }
        
    }
}

#Preview {
    RecipeCardsView(vm: RecipeBookViewModel())
}
