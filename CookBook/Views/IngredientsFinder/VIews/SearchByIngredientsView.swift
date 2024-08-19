//
//  SearchByIngredientsView.swift
//  CookBook
//
//  Created by Manu on 2024-08-13.
//

import SwiftUI
import TagLayoutView




struct SearchByIngredientsView: View {
    
    @Environment(\.dismiss) var dismissView
    
    @ObservedObject var vm = SearchByIngredientsViewModel()
    
    @State var ingredient: String = ""
    @State var isSearchingStarted: Bool = false
    
    func getRecipeById(id: Int) async {
        do {
            print("fetching")
            let res = try await APIManager(urlSession: .init(configuration: .default)).fetchRecipeById(
                id: id
            )
            print("Done Fetching - \(res ?? nil)")
            
        }catch{
            print("Error in fetching ...", (error.localizedDescription))
        }
    }
    
    
    @State var ingredients: [String] = []
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    VStack{
                        
                        VStack{
                            HStack{
                                if isSearchingStarted{
                                    Image(systemName: "ellipsis.rectangle.fill")
                                        .foregroundStyle(.akGreen)
                                        .fontWeight(.bold)
                                        .imageScale(.large)
                                        .onTapGesture {
                                            isSearchingStarted = false
                                            vm.recipeData = []
                                        }
                                }
                                
                                TextField("Type Ingredients", text: $ingredient)
                                    .font(.custom("Poppins-Medium", size: 13))
                                    .onChange(of: ingredient) {
                                        handleSpacePress(ingredient)
                                    }
                                if !ingredients.isEmpty
                                {
                                    
                                    Button {
                                        let ingredientsString = GetStringFromArray.withoutWhiteSpace(
                                            Array: ingredients
                                        )
                                            .getString
                                        withAnimation(.smooth) {
                                            isSearchingStarted = true

                                        }
                                        Task{
                                            await vm.fetchRecipe(with: ingredientsString)
                                        }
                                        
                                    } label: {
                                        Image(systemName: "magnifyingglass")
                                            .padding(8)
                                            .background(.akGreen)
                                            .clipShape(Circle())
                                            .foregroundStyle(.white)
                                    }
                                    .transition(.scale)
                                    
                                    
                                }
                            }
                            .padding()
                            .background(.akBg)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                        }
                        .animation(.easeInOut(duration: 0.3), value: ingredients.isEmpty)
                        .padding(.horizontal, 20)
                        //                    .padding(.top, 120)
                        
                        if !isSearchingStarted {
                            VStack(alignment: .leading){
                                VStack(alignment: .center){
                                    GeometryReader { geometry in
                                        TagLayoutView(
                                            ingredients,
                                            tagFont: UIFont
                                                .systemFont(
                                                    ofSize: 18
                                                ),
                                            padding: 30,
                                            parentWidth: geometry.size.width
                                        ) { tag in
                                            Text(tag)
                                                .font(.custom("Poppins-Medium", size: 13))
                                                .padding(EdgeInsets(top: 8, leading: 17, bottom: 8, trailing: 17))
                                                .foregroundColor(Color.white)
                                                .background(Color.akGreen)
                                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                                .onTapGesture {
                                                    ingredients.removeAll { s in
                                                        s == tag
                                                    }
                                                }
                                            
                                        }.padding(.all, 16)
                                        
                                    }
                                    
                                }
                                .padding(.horizontal, 20)
                                
                                
                                
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }else{
                            VStack{
                                if let recipeData = vm.recipeData {
                                    
                                   
                                    
                                    if vm.isLoading {
                                        ProgressView()
                                            .padding(.top, 60)
                                    }else if recipeData.isEmpty{
                                        Text("Could not find :(")
                                            .padding(.top, 60)
                                    }else{
                                        ForEach(recipeData, id: \.self) { data in
                                            NavigationLink(value: data) {
                                                RecipeCellVIewLarge(data: data)
                                             
                                            }
                                            .tint(.white)
                                        }
                                    }
                                }else{
                                    ProgressView()
                                        .padding(.top, 60)
                                }
                            }
                        }
                        
                        
                     
                    }
                    
                    
                }
            }
            .navigationDestination(for: FetchedRecipeByIngredients.self, destination: { data in
                RecipeDetailsByIdView(recipeId: data.id)
                    .navigationBarBackButtonHidden()

            })
            .padding(.top, 30)
            .navigationTitle("Search By Ingredients")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismissView()
                    } label: {
                        Text("Back")
                            .foregroundStyle(.akGreen)
                            .font(.custom("Poppins-Medium", size: 15))
                            

                        
                    }

                }
            }
            
        }
        
    }
    
    private func handleSpacePress(_ newValue: String) {
        // Check if the last character is a space
        if newValue.last == " " {
            // Trim the space and add the ingredient to the list
            let trimmedIngredient = newValue.trimmingCharacters(in: .whitespaces)
            if !trimmedIngredient.isEmpty {
                ingredients.append(trimmedIngredient)
            }
            ingredient = ""
        }
    }
}

#Preview {
    SearchByIngredientsView()
}
