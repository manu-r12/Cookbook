//
//  CategoriesView.swift
//  CookBook
//
//  Created by Manu on 2024-07-26.
//

import SwiftUI

struct CategoriesView: View {
    @Binding var selectedCatg: Category
    
    var body: some View {
        VStack{
            ScrollView(.horizontal){
                HStack(spacing: 10){
                    ForEach(
                        Category.allCases
                    ){catg in
                        HStack(spacing: 7){
                            Text(catg.rawValue)
                        }
                        .padding(.horizontal, 16)
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(selectedCatg == catg ? .white : .secondary)
                        .frame(height: 38)
                        .background(selectedCatg == catg ? .akGreen: .akBg)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .onTapGesture {
                            withAnimation(.snappy) {
                                selectedCatg = catg
                            }
                        }
                    }
                }
                .padding()
                
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    CategoriesView(selectedCatg: .constant(.all))
}
