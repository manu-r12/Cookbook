//
//  RegisterUserView.swift
//  CookBook
//
//  Created by Manu on 2024-05-16.
//

import SwiftUI

struct RegisterUserNameView: View {
    
    @ObservedObject var viewModel: RegisterUserViewModel
    
    @State var isImageGallaryOpen: Bool = false
  
    
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
                            Image(systemName: "photo")
                                .font(.system(size: 32))
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
                        Text("Enter yout username")
                            .font(.custom("Poppins-Regular", size: 18))
                    
                    }
                    .multilineTextAlignment(.center)
                    .frame(width: 200)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 20)
            
            VStack {
                Button(action: {
                    
                    Task{
                        await viewModel.completeUserSignUp()
                    }
                   
                }, label: {
                    Text("Finish")
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
        .photosPicker(isPresented: $isImageGallaryOpen, selection: $viewModel.pickedItem)
        
        .padding(.top, 20)
        
    }
}

#Preview {
    RegisterUserNameView(viewModel: RegisterUserViewModel())
}
