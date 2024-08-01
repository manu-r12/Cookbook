//
//  MediumSizeOptionBox.swift
//  CookBook
//
//  Created by Manu on 2024-08-01.
//

import SwiftUI

struct MediumSizeOptionBox: View {
    let title: String
    let bgColor: Color
    let icon: String
    let action: () -> Void

    
    var body: some View {
        Button {
            action()
        } label: {
            VStack{
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "\(icon)")
                        Spacer()
                        Image(systemName: "arrow.up.right")
                        
                    }
                    .font(.system(size: 21))
                    Spacer()
                    
                    VStack(alignment: .leading){
                        Text(title)
                            .font(.custom("Poppins-Medium", size: 15))
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(20)
                .frame(width: 170, height: 115)
                .background(bgColor)
                .clipShape(RoundedRectangle(cornerRadius: 18))
            }
        }
        .tint(.white)
        


    }
}

#Preview {
    MediumSizeOptionBox(
        title: "Hello Hello Hello Hello Hello",
        bgColor: .akBg ,
        icon: "magnifyingglass",
        action: {})
}
