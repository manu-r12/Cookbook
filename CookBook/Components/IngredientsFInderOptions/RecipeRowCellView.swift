//
//  RecipeRowCellView.swift
//  CookBook
//
//  Created by Manu on 2024-08-06.
//

import SwiftUI

struct RecipeRowCellView: View {
    let recipeData: FetchedRecipe
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 10){
                VStack{
                    RecipeCircleImage(imageUrl: recipeData.image    )
                }
                .frame(width: 50, height: 50)
                
                VStack(alignment: .leading){
                    Text("\(recipeData.title)")
                        .font(.custom("Poppins-Medium", size: 16))
                    
                    
                    HStack{
                        ForEach(
                            Array(recipeData.dishTypes.enumerated()),
                            id: \.offset
                        ) { idx, item in
                            if idx < 4 {
                                
                                Text("\(recipeData.dishTypes[idx])")
                                    .font(.custom("Poppins-Regular", size: 12))
                                    .frame(height: 10)
                                    .clipped()
                                
                                
                            }
                        }
                    }
                }
                .frame(width: 225, alignment: .leading)
                
                VStack{
                    VStack(spacing: 10){
                        Image(systemName: "clock")
                        Text("\(recipeData.readyInMinutes) min")
                            .font(.custom("Poppins-Regular", size: 13))
                        
                    }
                    
                }
                .frame(width: 62)
                
            }
        }
        .padding(12)
        .frame(width: 370, height: 85 ,alignment: .leading)
        .background(.akBg)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    RecipeRowCellView(
        recipeData: .init(
            id: 2,
            title: "Chicken Curry",
            image: "https://myfoodstory.com/wp-content/uploads/2020/10/Dhaba-Style-Chicken-Curry-2-500x375.jpg",
            dishTypes: ["mddddddsain", "non-veg main itemddd", "dinner"],
            servings: 3,
            readyInMinutes: 12,
            summary: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs might be a good recipe to expand your main course repertoire."
        )
    )
}
