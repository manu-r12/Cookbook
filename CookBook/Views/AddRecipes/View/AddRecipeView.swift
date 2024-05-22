//
//  AddRecipeView.swift
//  CookBook
//
//  Created by Manu on 2024-04-20.
//

import SwiftUI

struct AddRecipeView: View {
    
    @State var isPresenting: Bool = false
    
    var body: some View {
        ZStack{
 
            ScrollView{
                VStack{
                    HStack(alignment: .center,spacing: 20){
                        VStack(alignment: .leading, spacing: 15){
                            
                            Text("Add a Recipe")
                                .font(.custom("NotoSans-SemiBold", size: 25))
                                
                        }
                        Spacer()
                        VStack{
                            Button(action: {
                                isPresenting.toggle()
                            }, label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 35))
                                    .foregroundStyle(.akGreen)
                            })
                            
                        }
                    }
                    .padding()
                }
            }
        }
        .fullScreenCover(isPresented: $isPresenting, content: {
            AddRecipeDetailsView()
        })
    }
}

#Preview {
    AddRecipeView()
}
