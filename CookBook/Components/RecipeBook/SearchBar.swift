//
//  SearchBar.swift
//  CookBook
//
//  Created by Manu on 2024-07-26.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var body: some View {
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
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
