//
//  HomeScreenView.swift
//  CookBook

//  Created by Manu on 2024-04-18.
//

import SwiftUI


struct RecipeBookView: View {
    
    
    let vm = RecipeBookViewModel()
    
    @State var searchText: String = ""
    
    @State var isAddRecipeViewOpen = false
 
  
    
    var body: some View {
            ZStack{
                ScrollView{
                    //Header
                    Header(vm: vm)
                    
                    //Search bar
                    SearchBar(searchText: $searchText)
                    
                    //Recipe Items
                    RecipeCardsView(vm: vm)
                    
                }
                .scrollIndicators(.hidden)
                .refreshable(action: {
                    Task{
                        await vm.refreshData()
                    }
                })
                
                FloatingButton(action: {
                    isAddRecipeViewOpen.toggle()
                }, icon: "plus")
            }
            .fullScreenCover(isPresented: $isAddRecipeViewOpen, content: {
                AddRecipeDetailsView()
            })
            .ignoresSafeArea([.container])
    }
}

#Preview {
    RecipeBookView()
}
