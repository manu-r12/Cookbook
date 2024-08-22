//
//  BookmarkView.swift
//  CookBook
//
//  Created by Manu on 2024-08-22.
//

import SwiftUI

struct BookmarkView: View {
    @ObservedObject var vm = BookmarksViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                
                if !vm.isFetching{
                    if !vm.bookmarks.isEmpty{
                    
                        ScrollView {
                            
                            VStack(){
                                Text("Bookmarks")
                                    .font(.custom("Poppins-SemiBold", size: 29))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(.akGreen)
                                
                                VStack{
                                    HStack(spacing: 20){
                                        Image(systemName: "magnifyingglass")
                                            .imageScale(.large)
                                        TextField(text: .constant("")) {
                                            Text("Search your recipe")
                                                .font(.custom("Poppins-Medium", size: 17))
                                        }
                                        //                .focused($isEditing)
                                    }
                                    .padding()
                                    .frame(height: 55)
                                    .background(.akBg)
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                }

                            }
                            .padding(.bottom, 14)
                            
                            VStack(spacing: 15){
                                ForEach(vm.bookmarks, id:
                                            \.self) { recipe in
                                    NavigationLink(value: recipe) {
                                        RecipeRowCellView(recipeData: recipe)
                                            .tint(.primary)
                                    }
                                }
                            }

                        }
                    }else{
                        VStack{
                            Text("No Bookmarks Found")
                                .font(.custom("Poppins-Medium", size: 19))
                        }
                    }
                }else{
                    VStack{
                        Text("Loading..")
                            .font(.custom("Poppins-Medium", size: 19))

                    }
                }
            }
            .navigationDestination(for: FetchedRecipe.self, destination: { recipe in
                RecipeDetailsVIew(recipeData: recipe)
                    .navigationBarBackButtonHidden()
            })
            .padding(.top, 80)
            .padding(.horizontal, 15)
            .ignoresSafeArea(.all)
       
        }
        .onAppear {
            Task{
               await vm.getBookmarks()
            }
        }
    
    }
}

#Preview {
    BookmarkView()
}
