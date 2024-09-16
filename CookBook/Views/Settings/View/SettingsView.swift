//
//  SettingsView .swift
//  CookBook
//
//  Created by Manu on 2024-08-23.
//

import SwiftUI
import Kingfisher
let url = "https://images.seattletimes.com/wp-content/uploads/2023/07/07222023_swift_213100.jpg?d=2040x1479"
struct SettingsView: View {
    @State var isEditProfileViewOpen: Bool = false
    
    @ObservedObject var vm = SettingsViewModel()
    
    
    var body: some View {
        VStack{
            VStack{
                if let userImage = vm.user?.profileImage {
                    KFImage(URL(string: userImage))
                        .resizable()
                        .scaledToFill()
                }
                else{
                    ProgressView()
                        .tint(.akGreen)
                }
            }
            .frame(width: 160, height: 160)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(style: .init(lineWidth: 5))
                    .fill(Color.akGreen)
            }
            
            VStack{
                if let userName = vm.user?.username{
                    Text("Hello, \(userName)")
                        .font(.custom("Poppins-Medium", size: 22))
                }else{
                    Text(".....")
                        .font(.custom("Poppins-Medium", size: 22))
                }
            

            }
            .padding(.top, 18)
            
            //Buttons
            VStack{
                VStack{
                    Button(action: {
                        
                        Task{
                            isEditProfileViewOpen.toggle()
                        }
                        
                    }, label: {
                        Text("Edit Profile")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(.akGreen)
                            .cornerRadius(35)
                            .padding()
                            .tint(.white)
                            .font(.custom("Poppins-Medium", size: 17))
                    })
                }
            }
        }
        .onAppear(perform: {
            Task{
                await vm.fetchUserDetails()
            }
        })
        .sheet(isPresented: $isEditProfileViewOpen) {
            EditProfileVIew(
                viewModel: vm
            )
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
    }
}

#Preview {
    SettingsView()
}
