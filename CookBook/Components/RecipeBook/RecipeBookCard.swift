//
//  RecipeBookCard.swift
//  CookBook
//
//  Created by Manu on 2024-07-26.
//

//let adults = people.filter { $0.age >= 30 }


import SwiftUI

struct RecipeBookCard: View {
    let recipeData: [RecipeModel]
    let category: Category
    
    var filteredData: [RecipeModel] {
        
        if category != .all {
            return recipeData.filter { $0.category.contains(category.rawValue)}
        }else{
            return recipeData
        }
    }
    
    var body: some View {
        ForEach(filteredData , id: \.self) { data in
            VStack(alignment: .leading ,spacing: 7){
                HStack(spacing: 220){
                    VStack {
                        RecipeCircleImage(
                            imageUrl: data.imageUrl
                        )
                    }
                    .frame(width: 50, height: 50)
                    
                    HStack(spacing: 6){
                        Image(systemName: "clock")
                        Text(data.cookingTime)
                            .font(.custom("Poppins-Regular", size: 15))
                            .kerning(1)
                    }
                }
                
                VStack(alignment: .leading, spacing: 15){
                    Text(data.name)
                        .font(.custom("Poppins-Medium", size: 18))
                    Text(data.instructions)
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundStyle(Color(.systemGray))
                    
                }
                .frame(
                    width: 320,
                    height: 100,
                    alignment: .leading
                )
                
                
                VStack{
                    
                    HStack(spacing: 199){
                        HStack {
                            Text("🥗")
                                .font(.system(size: 20))
                            Text("Dinner")
                        }
                        
                        HStack{
                            Image(systemName: "heart")
                                .imageScale(.large)
                        }
                    }
                    .kerning(1)
                    .font(.custom("Poppins-Regular", size: 14))
                    
                    
                }
                .frame(width: 320, alignment: .leading)
                .padding(.vertical, 10)
                
            }
            .padding(.horizontal, 10)
            .frame(maxWidth: 340,alignment: .leading)
            .padding(8)
            .padding(.top, 8)
            .background(.akBg)
            .clipShape(RoundedRectangle(cornerRadius: 4))
        }
    }
}

