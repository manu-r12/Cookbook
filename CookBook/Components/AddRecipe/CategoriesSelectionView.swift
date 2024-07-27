//
//  CategoriesSelectionView.swift
//  CookBook
//
//  Created by Manu on 2024-07-27.
//

import SwiftUI

struct CategoriesSelectionView: View {
//    @Binding var selectedCategories: Category
    @Binding var category: [String]

    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing: 8){
                ForEach(Category.allCases){ catg in
                    VStack{
                        Text("\(catg.rawValue)")
                            .padding(.horizontal, 8)
                            .frame(
                                width: 100,
                                height: 40,
                                alignment: .center
                            )
                        
                            .background(.akBg)
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 18
                                )
                            )
                    }
                    .onTapGesture {
                        category.append(catg.rawValue)
                    }
                }
            }
        }.padding(8)
    }
}

#Preview {
    CategoriesSelectionView(category: .constant([""]))
}
