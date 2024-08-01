//
//  MediumSizeOptionBox.swift
//  CookBook
//
//  Created by Manu on 2024-08-01.
//

import SwiftUI

struct LargeSizeOptionBox: View {
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
                            .font(.system(size: 28))
                        Spacer()
                        Image(systemName: "arrow.up.right")
                        
                    }
                    .font(.system(size: 28))
                    
                    Spacer()
                    Text("\(title)")
                        .font(.custom("Poppins-Medium", size: 20))
                        .frame(width: 140, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
                .padding(20)
                .frame(width: 170, height: 240)
                .foregroundStyle(.white)
                .background(bgColor)
                .clipShape(RoundedRectangle(cornerRadius: 18))
            }
        }
        .tint(.white)
        
        
        
    }
}

#Preview {
    LargeSizeOptionBox(
        title: "Hello Hello Hello Hello Hello",
        bgColor: .akBg ,
        icon: "magnifyingglass",
        action: {})
}
