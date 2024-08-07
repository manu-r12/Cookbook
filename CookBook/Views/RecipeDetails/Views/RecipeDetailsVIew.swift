//
//  RecipeDetailsVIew.swift
//  CookBook
//
//  Created by Manu on 2024-08-06.
//

import Kingfisher
import SwiftUI

struct RecipeDetailsVIew: View {
    let recipeData: FetchedRecipe
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm = RecipeDetailsVIewModel()

    var body: some View {
        ScrollView {
            // header
            ZStack(alignment: .topLeading) {

                VStack {
                    KFImage(URL(string: recipeData.image))
                        .resizable()
                        .scaledToFill()
                }
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 28))


                Button(
                    action: {
                        print("Hello..")
                        dismiss()
                    },
                    label: {
                        VStack {

                            Image(systemName: "chevron.left")
                                .imageScale(.large)
                                .foregroundStyle(.akGreen)
                                .background(
                                    Circle().fill(Color.black).frame(
                                        width: 42,
                                        height: 42
                                    )
                                )
                        }
                        .padding(.vertical, 70)
                        .padding(.horizontal, 40)

                    })
            }
            // image of the recipe
            VStack {
                VStack{
                    Text(recipeData.title)
                        .font(.custom("Poppins-Medium", size: 22))
                }
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack{
                    HStack{
                        HStack{
                            Image(systemName: "clock")
                            Text("\(recipeData.readyInMinutes) min")                            .font(.custom("Poppins-Regular", size: 15))
                        }
                        
                    }
                    .padding(.horizontal, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 2)
                }
                
                VStack(alignment: .leading){
                    Text("Description")
                        .font(.custom("Poppins-Medium", size: 18))
                    
                    VStack{
                        Text(recipeData.summary)
                            .font(.custom("Poppins-Regular", size: 15))
                    }
                    .padding()
                    .frame(width: 380, height: 160, alignment: .topLeading)
                    .background(.akBg)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 14)

                    
            }
            .padding(.top, 30)

        }
        .ignoresSafeArea()

    }
}

#Preview {
    RecipeDetailsVIew(
        recipeData: .init(
            id: 2,
            title: "Chicken Curry",
            image:
                "https://myfoodstory.com/wp-content/uploads/2020/10/Dhaba-Style-Chicken-Curry-2-500x375.jpg",
            dishTypes: ["mddddddsain", "non-veg main itemddd", "dinner"],
            servings: 3,
            readyInMinutes: 12,
            summary: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs might be a good recipe to expand your main course repertoire.Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs might be a good recipe to expand your main course repertoire.Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs might be a good recipe to expand your main course repertoire."
        ))
}
