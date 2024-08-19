//
//  RecipeDetailsVIew.swift
//  CookBook
//
//  Created by Manu on 2024-08-06.
//

import Kingfisher
import SwiftUI

struct RecipeDetailsByIdView: View {
    let recipeId: Int
    
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm = RecipeDetailsViewModel()
    
    var body: some View {
        if let recipeData = vm.fetchedRecipeDataById {
        VStack{
                ScrollView {
                    // header
                    VStack{
                        ZStack(alignment: .topLeading) {
                            
                            VStack {
                                KFImage(URL(string: recipeData.image))
                                    .resizable()
                                    .scaledToFill()
                            }
                            .frame(width: 400, height: 300)
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
                    }
                    
                    
                    VStack {
                        HStack{
                            VStack{
                                Text(recipeData.title)
                                    .font(.custom("Poppins-Medium", size: 22))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack{
                                
                                Button {
                                    
                                } label: {
                                    Image(systemName: "heart")
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
                                    Text("\(12) min")                            .font(.custom("Poppins-Regular", size: 15))
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
                                Text("")
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
                            
                            
                            VStack(spacing: 10){
                                
                                if vm.isIngredientsFetching {
                                    VStack{
                                        HStack{
                                            Text("Fetching....")
                                            
                                        }
                                    }
                                    .padding(20)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .background(.akBg)
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                }else{
                                    
                                    if let ingredients = vm.ingredients {
                                        ForEach(
                                            ingredients.ingredients,
                                            id: \.self) { ingredient in
                                                VStack{
                                                    HStack{
                                                        HStack {
                                                            VStack{
                                                                KFImage(
                                                                    URL(
                                                                        string: getImageUrlOfIngredient(
                                                                            imageName: ingredient.image
                                                                        )
                                                                    )
                                                                )
                                                                .onFailureImage(.remove)
                                                                .placeholder({
                                                                    ProgressView()
                                                                })
                                                                .resizable()
                                                                .scaledToFill()
                                                                .clipShape(Circle())
                                                                
                                                            }.frame(
                                                                width: 35,
                                                                height: 35
                                                            )
                                                            Text("\(capitalizedString(ingredient.name))")
                                                                .font(.custom("Poppins-Regular", size: 15))
                                                            
                                                            
                                                        }
                                                        
                                                        Spacer()
                                                        Text("\(String(format: "%.1f", ingredient.amount.us.value)) \(ingredient.amount.us.unit)")
                                                            .font(.custom("Poppins-Regular", size: 15))
                                                        
                                                    }
                                                }
                                                .padding(17)
                                                .frame(maxWidth: .infinity,alignment: .leading)
                                                .background(.akBg)
                                                .clipShape(RoundedRectangle(cornerRadius: 14))
                                            }
                                        
                                        
                                    }else {
                                        VStack{
                                            HStack{
                                                Text("Sorry Couldn't find any Ingredients")
                                            }
                                        }
                                        .padding(20)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                        .background(.akBg)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                    }
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
                                    if vm.isInstructionsFetching{
                                        Text("Fetching...")
                                        
                                    }else{
                                        if !vm.instructions.isEmpty {
                                            ForEach(vm.instructions, id: \.self) { instruction in
                                                ForEach(instruction.steps, id: \.self) { step in
                                                    Text(step.step)
                                                        .font(.custom("Poppins-Regular", size: 15))
                                                    
                                                }
                                            }
                                        }else{
                                            Text("Sorry Couldn't find any instructions")
                                        }
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
                        await vm.getIngredientByRecipeId(id: recipeData.id)
                        await vm.getRecipeInstrucions(id: recipeData.id)
                    }
                })
                .scrollIndicators(.hidden)
            }
            .ignoresSafeArea()
            
        }else{
            VStack{
                Text("Loading...")
            }
            .onAppear(perform: {
                Task{
                    await vm.getRecipeById(id: recipeId)
                }
            })
        }
        
    }
    
    
    private func capitalizedString(_ string: String) -> String {
        return string.capitalized // Capitalizes the first letter of each word
    }
    
    private func getImageUrlOfIngredient(imageName: String) -> String{
        
        return "https://img.spoonacular.com/ingredients_100x100/\(imageName)"
        
    }
}

#Preview {
    RecipeDetailsByIdView(recipeId: 3)
}
