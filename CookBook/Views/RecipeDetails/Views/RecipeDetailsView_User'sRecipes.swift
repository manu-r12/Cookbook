//
//  RecipeDetailsVIew.swift
//  CookBook
//
//  Created by Manu on 2024-08-06.
//

import Kingfisher
import SwiftUI

import FirebaseAuth
struct RecipeDetailsView_UserRecipes: View {
    let recipeData: RecipeModel
    
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm = RecipeDetailsViewModel()
    
    @State var isRecipeBookmarked: Bool = false
    
    // todo: this is gonna fetch the value from new catogory (Bookmarks for user created recipe)
    // steps: if the property does not exist create it
    // otherwise update it with the new value(that property is the array)
    
    @MainActor
//    func isBookmarked() async  {
//        let val = await Bookmarks
//            .isRecipeBookmarked(
//                recipeId: 2           )
//        isRecipeBookmarked = val
//    }
    

    var body: some View {
        VStack{
            ScrollView {
                // header
                VStack{
                    ZStack(alignment: .topLeading) {
                        
                        VStack {
                            KFImage(URL(string: recipeData.imageUrl))
                                .resizable()
                                .scaledToFill()
                        }
                        .frame(width: 400,height: 300)
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
                                            Circle().fill(Color.white).frame(
                                                width: 42,
                                                height: 42
                                            )
                                        )
                                }
                                .padding(.vertical, 70)
                                .padding(.horizontal, 40)
                                
                            })
                    }
                }
                
                
                VStack {
                    HStack{
                        VStack{
                            Text(recipeData.name)
                                .font(.custom("Poppins-Medium", size: 22))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack{
                            
                            Button {
//                                Task{
//                                    await vm
//                                        .uploadBookmarkedRecipe(
//                                            recipe: recipeData
//                                        )
//                                }
                            } label: {
                                Image(systemName: isRecipeBookmarked ? "heart.fill" : "heart")
                                    .imageScale(.large)
                            }
                            .tint(.akGreen)
                            
                        }
                        .padding(.trailing, 20)
                    }
                    .padding(.horizontal, 15)
                    
                    
                    VStack{
                        HStack{
                            HStack{
                                Image(systemName: "clock")
                                Text("\(recipeData.cookingTime) min")
                                    .font(.custom("Poppins-Regular", size: 15))
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
                            Text("Not Avaiable Right Now!!")
                                .font(.custom("Poppins-Regular", size: 15))
                        }
                        .padding()
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: 160,
                            alignment: .topLeading
                        )
                        .background(.akBg)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .padding(.horizontal, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 14)
                    
                    
                    VStack(alignment: .leading){
                        Text("Ingredients")
                            .font(.custom("Poppins-Medium", size: 18))
                        
                        // ingredients show
                        VStack(spacing: 10){
                            
                            ForEach(
                                recipeData.ingredients,
                                id: \.self) { ingredient in
                                    VStack{
                                        HStack{
                                            HStack {
                                                
                                                Text("\(capitalizedString(ingredient.nameOfIngredient))")
                                                    .font(.custom("Poppins-Regular", size: 15))
                                                
                                                
                                            }
                                            
                                            Spacer()
                                            Text("\(ingredient.quantity)")
                                                .font(.custom("Poppins-Regular", size: 15))
                                            
                                        }
                                    }
                                    .padding(17)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .background(.akBg)
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                }
                         
                        }
                        .padding(.top, 10)
                        
                    }
                    .padding(.horizontal, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 14)
                    
                    VStack(alignment: .leading){
                        Text("Instructions")
                            .font(.custom("Poppins-Medium", size: 18))
                        
                        
                        VStack(){
                            VStack(alignment: .leading){
                                // todo: we already have the instructions we do not need to fetch any more
                    
                                    if !recipeData.instructions.isEmpty {
                                        Text(recipeData.instructions)
                                    }else{
                                        Text("Sorry Couldn't find any instructions")
                                    
                                }
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .background(.akBg)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .padding(.top, 10)
                        
                    }
                    .padding(.horizontal, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 14)
                }
                .padding(.horizontal,3)
                .padding(.top, 30)
                .padding(.bottom, 60)
            }
            .onAppear(perform: {
                Task{
                    try await vm.getUserCreatedRecipes(recipeID: recipeData.id)
                }
            })
            .scrollIndicators(.hidden)
            
        }
        .ignoresSafeArea()
        
        
    }
    
    
    private func capitalizedString(_ string: String) -> String {
        
        return string.capitalized // Capitalizes the first letter of each word
        
    }
    
    private func getImageUrlOfIngredient(imageName: String) -> String{
        
        return "https://img.spoonacular.com/ingredients_100x100/\(imageName)"
        
    }
}

#Preview {
    RecipeDetailsView_UserRecipes(
        recipeData: .init(
            id: UUID.init(uuidString: "3351150E-C443-49E9-934F-6223752F999F"
)!,
            name: "Manu",
            imageUrl: "kjnaks",
            ingredients: [],
            instructions: "asdas", Note:
                "",
            category: [],
            preprationTime: "as",
            cookingTime: "da"
        )
    )
}
