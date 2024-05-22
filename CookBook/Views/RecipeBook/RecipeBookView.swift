//
//  HomeScreenView.swift
//  CookBook

//  Created by Manu on 2024-04-18.
//

// the main theme would be
import SwiftUI

struct RecipeBookView: View {
    
    @ObservedObject var AuthManager = AuthenticationManager.shared
    
    
    @State var searchText: String = ""
    @State var selectedCatg: String = "Breakfast"
    
    var body: some View {
        ZStack{
            
            ScrollView{
                VStack{
                    HStack(spacing: 20){
                        VStack(alignment: .leading, spacing: 15){
                            Text("Hello Anne")
                                .font(.custom("NotoSans-Medium", size: 17))
                                .foregroundStyle(Color(.gray))
                            
                            Text("What would you like to cook today?")
                                .font(.custom("NotoSans-SemiBold", size: 22))
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
                                .font(.custom("NotoSans-Medium", size: 17))
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
                        Text("Categories")
                            .font(.custom("NotoSans-Medium", size: 19))
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
                                    .font(.custom("NotoSans-Medium", size: 14))
                                    .foregroundColor(selectedCatg == catg.name ? .white : .white)
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
                    VStack{
                        Text("Your Recipies")
                            .font(.custom("NotoSans-Medium", size: 19))
                            .padding(.leading)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    
                    VStack(alignment: .leading,spacing: 25){
                        ForEach(DummyData().foods, id: \.self){food in
                            HStack(alignment: .top,spacing: 14){
                                Image(food.image)
                                    .resizable()
                                    .frame(width: 110, height: 110)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                VStack(alignment: .leading, spacing: 20){
                                    Text(food.name)
                                        .font(.custom("NotoSans-Medium", size: 18))
                                    Text(food.description)
                                        .font(.custom("NotoSans-Regular", size: 15))
                                        .foregroundStyle(Color(.systemGray))
                                    
                                }
                                .frame(width: 220, height: 100)
                                
                            }
                            .padding(8)
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
