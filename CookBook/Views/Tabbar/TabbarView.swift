//
//  TabbarView.swift
//  CookBook
//
//  Created by Manu on 2024-04-19.
//

import SwiftUI

struct TabbarView: View {
    @State var selectedTab: SelectedTabs = .Book
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
 
    
    var body: some View {
        ZStack{
            VStack{
                TabView(selection: $selectedTab){
                    RecipeBookView()
                        .tag(SelectedTabs.Book)
                    
                    IngredinetsFinderView()
                        .tag(SelectedTabs.Search)
                    
                    AddRecipeView()
                        .tag(SelectedTabs.Add)
                    
                    Text("Bookmark")
                        .tag(SelectedTabs.Bookmark)
                    
                    Text("Settings")
                        .tag(SelectedTabs.Settings)
                    
                }
            }
            
            VStack{
                Spacer()
                CustomTabbarView(selectedTab: $selectedTab)
                    .padding(.bottom, -20)
            }
        }
       
    }
}

#Preview {
    TabbarView()
}
