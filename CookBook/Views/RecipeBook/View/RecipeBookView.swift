//
//  HomeScreenView.swift
//  CookBook

//  Created by Manu on 2024-04-18.
//

import SwiftUI

struct RecipeBookView: View {
    
    @ObservedObject var AuthManager = AuthenticationManager.shared
    
    var vm = RecipeBookViewModel()
    
    @State var searchText: String = ""
    @State var selectedCatg: String = "Breakfast"
    
    var body: some View {
        ZStack{
            
            ScrollView{
                VStack{
                    HStack(spacing: 20){
                        VStack(alignment: .leading, spacing: 15){
                            Text("Hello Anne")
                                .font(.custom("Poppins-Medium", size: 17))
                                .foregroundStyle(Color(.gray))
                            
                            Text("What would you like to cook today?")
                                .font(.custom("Poppins-SemiBold", size: 22))
                                .onTapGesture {
                                    AuthenticationManager.shared.signOut()
                                }
                        }
                        VStack{
                            Image("cook2")
                                .resizable()
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.top, 60)
                
                //Search bar
                VStack{
                    HStack(spacing: 20){
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                        TextField(text: $searchText) {
                            Text("Search your recipe")
                                .font(.custom("Poppins-Medium", size: 17))
                        }
                    }
                    .padding()
                    .frame(height: 45)
                    .background(.akBg)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding(20)
                }
                
                //Catogories Selection
                VStack{
                    VStack(alignment: .leading){
                        Text("Your Recipies")
                            .font(.custom("Poppins-Medium", size: 19))
                            .padding(.leading)
                        
                        
                        ScrollView(.horizontal){
                            HStack(spacing: 10){
                                ForEach(DummyData().catogories, id: \.self){catg in
                                    HStack(spacing: 7){
                                        Text(catg.emoji)
                                            .font(.system(size: 20))
                                        Text(catg.name)
                                    }
                                    .padding(.horizontal, 16)
                                    .font(.custom("Poppins-Medium", size: 14))
                                    .foregroundColor(selectedCatg == catg.name ? .white : .secondary)
                                    .frame(height: 38)
                                    .background(selectedCatg == catg.name ? .akGreen: .akBg)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .onTapGesture {
                                        withAnimation(.snappy) {
                                            selectedCatg = catg.name
                                        }
                                    }
                                }
                            }
                            .padding()
                            
                        }
                        .scrollIndicators(.hidden)
                        
                    }
                }
                //Recent Viewed Recipes
                VStack{
                    
                    VStack(alignment: .leading,spacing: 25){
                        ForEach(DummyData().foods, id: \.self){food in
                            VStack(alignment: .leading ,spacing: 7){
                                HStack(spacing: 190){
                                    VStack {
                                        Image(food.image)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())
                                    }
                                    HStack(spacing: 6){
                                        Image(systemName: "clock")
                                        Text("15min")
                                            .font(.custom("Poppins-Regular", size: 15))
                                            .kerning(1)
                                    }
                                    
                                    
                                }
                                
                           
                                
                                
                                VStack(alignment: .leading, spacing: 15){
                                    Text(food.name)
                                        .font(.custom("Poppins-Medium", size: 18))
                                    Text(food.description)
                                        .font(.custom("Poppins-Regular", size: 15))
                                        .foregroundStyle(Color(.systemGray))
                                    
                                }
                                .frame(width: 320, height: 100)
                                
                                
                                VStack{
                                    
                                    HStack(spacing: 199){
                                        HStack {
                                            Text("🥗")
                                                .font(.system(size: 20))
                                            Text("Dinner")
                                        }
                                        
                                        HStack{
                                            Image(systemName: "heart")
                                                .imageScale(.large)
                                        }
                                    }
                                    .kerning(1)
                                    .font(.custom("Poppins-Regular", size: 14))
                                    
                                    
                                }
                                .frame(width: 320, alignment: .leading)
                                .padding(.vertical, 10)
                                
                            }
                            .padding(.horizontal, 10)
                            .frame(maxWidth: 340,alignment: .leading)
                            .padding(8)
                            .padding(.top, 8)
                            .background(.akBg)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            
                        }
                    }
                    .padding()
                }
            }
            .scrollIndicators(.hidden)
        }
        .ignoresSafeArea()
        
        
    }
}

#Preview {
    TabbarView()
}
