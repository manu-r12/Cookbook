// TabbarView.swift
// CookBook
//
// Created by Manu on 2024-04-19.
//

import SwiftUI


struct TabbarView: View {
    @State private var selectedTab: SelectedTabs = .Book
    
    var body: some View {
            TabView(selection: $selectedTab) {
                RecipeBookView()
                    .tabItem {
                        Image(systemName: "book")
                    }
                    .tag(SelectedTabs.Book)
                
                IngredientsFInderOptionsView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                    .tag(SelectedTabs.Search)
                
                
                BookmarkView()
                    .tabItem {
                        Image(systemName: "bookmark")
                    }
                    .tag(SelectedTabs.Bookmark)
                
                Text("Settings")
                    .tabItem {
                        Image(systemName: "gear")
                    }
                    .tag(SelectedTabs.Settings)
            }
            .padding(.top, 10)
            .tint(.white)
            .ignoresSafeArea()
     
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
