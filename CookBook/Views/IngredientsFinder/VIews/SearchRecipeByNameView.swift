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
    
    func getSearchResult() async {
        do {
            print("Getting the data")

            let res = try await   viewModel
                .fetchRecipesInfo(
                    query: searchTextInput,
                    numberOfRes: 5,
                    searchMethod: .SearchByTitle
                )
            print("Got the data => \(res)")
        }catch{
            print("Error in Fetching", error.localizedDescription)
        }
        
    }
    
    var body: some View {
        VStack(spacing: 20){
            VStack(spacing: 25){
                VStack {
                    Text("Select the Search Method")
                        .font(.custom("Poppins-Regular", size: 21))
                        .onTapGesture {
                            Task{
                                await getSearchResult()
                            }
                        }
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
            
            SearchBar(searchText: $searchTextInput)
        }
    }
}

#Preview {
    SearchRecipeByNameView( viewModel: IngredientsFInderOptionsViewModel())
}
