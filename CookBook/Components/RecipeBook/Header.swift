//
//  Header.swift
//  CookBook
//
//  Created by Manu on 2024-07-26.
//

import SwiftUI

struct Header: View {
    @ObservedObject var vm: RecipeBookViewModel
    
    var body: some View {
        VStack{
            HStack(spacing: 20){
                VStack(alignment: .leading, spacing: 15){
                    Text("Hello \(vm.user?.username ?? "Loading..")")
                        .font(.custom("Poppins-Medium", size: 17))
                        .foregroundStyle(Color(.gray))
                    
                    Text("What would you like to cook today?")
                        .font(.custom("Poppins-SemiBold", size: 22))
                        .onTapGesture {
                            AuthenticationManager.shared.signOut()
                        }
                }
                VStack{
                    UserCirclePFP(imageUrl: vm.user?.profileImage ?? "")
                }
                .frame(width: 55, height: 55)
                .clipShape(Circle())
                
                
                
            }
        }
        .padding(.top, 60)
    }
}

#Preview {
    Header(vm: RecipeBookViewModel())
}
