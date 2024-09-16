//
//  RegisterUserView.swift
//  CookBook
//
//  Created by Manu on 2024-05-16.
//

import SwiftUI
import Kingfisher

struct EditProfileVIew: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    
    @State var isImageGallaryOpen: Bool = false
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        
        VStack{
            Button {
                isImageGallaryOpen.toggle()
                
            } label: {
                VStack{
                    VStack{
                        if let image = viewModel.selectedImage{
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                        }else{
                            KFImage(
                                URL(string: viewModel.user?.profileImage ?? "")
                            )
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            
                        }
                        
                    }
                    .clipped()
                    
                    .padding(0)
                    .frame(width: 150, height: 150)
                    .overlay {
                        Circle().stroke()
                    }
                    
                    
                    
                    Text("Upload proflie ")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundStyle(.akGreen)
                        .padding(.top, 20)
                }
                .tint(.white)
                
            }
            
            VStack{
                VStack{
                    TextField(text: $viewModel.username) {
                        Text("\(viewModel.user?.username ?? "")")
                            .font(.custom("Poppins-Regular", size: 18))
                        
                    }
                    .multilineTextAlignment(.center)
                    .frame(width: 250)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 20)
            
            VStack {
                Button(action: {
                    
                    Task{
                        await viewModel.uploadEditedInfo()
                        dismiss()
                    }
                    
                }, label: {
                    Text(!viewModel.isUploading ? "Upload" : "Uploading...")
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .background(.white)
                        .cornerRadius(15)
                        .padding()
                        .tint(.black)
                        .font(.custom("Poppins-Medium", size: 18))
                })
            }
            .padding(.top, 50)
            
        }
        .onDisappear(perform: {
            Task{
                await viewModel.fetchUserDetails()
            }
        })
        .photosPicker(isPresented: $isImageGallaryOpen, selection: $viewModel.pickedItem)
        
        .padding(.top, 20)
        
    }
}

#Preview {
    EditProfileVIew(
        viewModel: SettingsViewModel()
    )
}
