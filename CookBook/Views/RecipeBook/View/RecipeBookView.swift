//
//  HomeScreenView.swift
//  CookBook

//  Created by Manu on 2024-04-18.
//

import SwiftUI


struct RecipeBookView: View {
    
    
    let vm = RecipeBookViewModel()
    
    @State var searchText: String = ""
    
 
  
    
    var body: some View {
        VStack {
            ZStack{
                ScrollView{
                    // Header
                    Header(vm: vm)
                    
                    //Search bar
                    SearchBar(searchText: $searchText)
                    
                    //                Recipe Items
                    RecipeCardsView(vm: vm)
                    
                }
                .scrollIndicators(.hidden)
                
                FloatingButton(icon: "plus")
            }
        
        }
        .ignoresSafeArea()
        
//
        
        
    }
}

#Preview {
    RecipeBookView()
}
