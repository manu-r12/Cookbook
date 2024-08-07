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
                
                
                RecipeDetailsVIew(
                    recipeData: .init(
                        id: 2,
                        title: "Chicken Curry",
                        image: "https://myfoodstory.com/wp-content/uploads/2020/10/Dhaba-Style-Chicken-Curry-2-500x375.jpg",
                        dishTypes: ["mddddddsain", "non-veg main itemddd", "dinner"],
                        servings: 3,
                        readyInMinutes: 12,
                        summary: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs might be a good recipe to expand your main course repertoire."
                    )
                )
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
