//
//  SearchRecipeByNameView.swift
//  CookBook
//
//  Created by Manu on 2024-08-02.
//

import SwiftUI
import Kingfisher

enum SearchMethods: String , CaseIterable {
    case SearchByTitle = "Search By Title"
    case SearchByName = "Search By Name"
    //    case /*Nothing*/
}

struct SearchRecipeByNameView: View {
    @State var searchTextInput: String = ""
    @State var selectedMethod: SearchMethods = .SearchByTitle
    @ObservedObject var viewModel: IngredientsFinderOptionsViewModel
    @State var showOptions: Bool = true
    
    @Environment(\.dismiss) var dismissView
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 20){
                    if showOptions {
                    VStack(spacing: 25){
                        VStack {
                            Text("Select the Search Method")
                                .font(.custom("Poppins-Regular", size: 21))
                        }
                        
                        HStack{
                            ForEach(SearchMethods.allCases, id: \.self){ method in
                                Button {
                                    withAnimation(.smooth) {
                                        selectedMethod = method
                                    }
                                    
                                    
                                } label: {
                                    Text(method.rawValue)
                                        .padding()
                                        .background(
                                            selectedMethod == method ? .akGreen : .akBg
                                        )
                                        .clipShape(RoundedRectangle(cornerRadius: 18))
                                        .kerning(0.86)
                                }
                                .tint(.white)
                                
                            }
                        }
                        
                    }
                    }
                    VStack{
                        SearchBar(searchText: $searchTextInput)
                            .onSubmit {
                                print("\(searchTextInput)")
                                withAnimation(.smooth) {
                                    showOptions = false

                                }
                                Task {
                                    await viewModel
                                        .startFetching(
                                            query: searchTextInput,
                                            searchMethod: selectedMethod
                                        )
                                }
                            }
                    }
                    
                    //Cell View
                    if !showOptions {
                        if viewModel.isFetchingData {
                            ProgressView().padding(.top, 60)
                            
                        }else{
                            VStack(spacing: 20){
                                if let recipeData = viewModel.fetchedResultData?.results {
                                    
                                    ForEach(recipeData, id: \.self){recipeInfo in
                                        NavigationLink(
                                            value: recipeInfo) {
                                                RecipeRowCellView(recipeData: recipeInfo)

                                            }
                                    }
                                }
                                else{
                                    Text("Nothing")
                                }
                            }
                        }
                    }
                    
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismissView()
                    } label: {
                        Text("Back")
                            .font(.custom("Poppins-Regular", size: 17))
                    }

                    

                }
            })
            .navigationDestination(for: FetchedRecipe.self) { recipeInfo in
                RecipeDetailsVIew(recipeData: recipeInfo)
                    .navigationBarBackButtonHidden()
            }
        }
    }
        
}

#Preview {
    SearchRecipeByNameView( viewModel: IngredientsFinderOptionsViewModel())
}
