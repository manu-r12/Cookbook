//
//  AddInstructionsSheetView.swift
//  CookBook
//
//  Created by Manu on 2024-04-20.
//

import SwiftUI

struct AddInstructionsSheetView: View {
    
    @Binding var text: String
    @Environment(\.dismiss) var dismissSheet
    var body: some View {
        VStack{
            HStack {
                Text("Add Instrcutions")
                    .font(.custom("Poppins-SemiBold", size: 25))
                    .foregroundStyle(.akGreen)
                Spacer()
                Button(action: {
                    dismissSheet()
                }, label: {
                    Text("Done")
                        .font(.custom("Poppins-Medium", size: 18))
                        .foregroundStyle(.white)
                })
                
                
            }
            .padding()
            
            ScrollView{
                VStack {
                    TextField("Add 1/2 sugar..............", text: $text, axis: .vertical)
                }
                .padding(10)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(10)
                .onTapGesture {
                    hideKeyboard()
                }
                
                
            }
            .background(.akBg)
            .padding()
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        hideKeyboard()
                    }
            )
            .clipShape(RoundedRectangle(cornerRadius: 17))
        }
    }
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//#Preview {
//    AddInstructionsSheetView(text: .constant(""))
//}
