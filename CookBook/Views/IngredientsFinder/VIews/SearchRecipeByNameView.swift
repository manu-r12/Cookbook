//
//  SearchRecipeByNameView.swift
//  CookBook
//
//  Created by Manu on 2024-08-02.
//

import SwiftUI

enum SearchMethod: String , CaseIterable {
    case SearchByTitle = "Search By Title"
    case SearchByName = "Search By Name"
    //    case /*Nothing*/
}

struct SearchRecipeByNameView: View {
    @State var searchTextInput: String = ""
    @State var selectedMethod: SearchMethod = .SearchByTitle
    @ObservedObject var viewModel: IngredientsFInderOptionsViewModel
    @State var showOptions: Bool = true
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                if showOptions {
                VStack(spacing: 25){
                    VStack {
                        Text("Select the Search Method")
                            .font(.custom("Poppins-Regular", size: 21))
                    }
                    
                    HStack{
                        ForEach(SearchMethod.allCases, id: \.self){ method in
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
                            showOptions = false
                            Task {
                                await viewModel
                                    .startFetching(
                                        query: searchTextInput,
                                        searchMethod: selectedMethod
                                    )
                            }
                        }
                }
                
                
            }
        }
    }
}

#Preview {
    SearchRecipeByNameView( viewModel: IngredientsFInderOptionsViewModel())
}
