//
//  LoginView.swift
//  CookBook
//
//  Created by Manu on 2024-06-03.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var authMode: AuthenticationType
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack{
            Image("welcomScreenBg")
                .resizable()
                .scaledToFill()
            
            VStack {
                VStack{
                    Text("Start cooking, Start exploring")
                        .font(.custom("Poppins-SemiBold", size: 37))
                        .foregroundStyle(.white)
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                
                
                VStack(alignment: .leading,spacing: 19){
                    
                    
                    VStack{
                        HStack(spacing: 5){
                            Image(systemName: "envelope.fill")
                                .foregroundStyle(.black)
                            TextField("Email", text: $viewModel.emailInput)
                                .foregroundStyle(.gray)
                                
                                
                              
                             
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .background(.white)
                        .cornerRadius(15)
                        .padding(.leading)
                        .padding(.trailing)
                       
                        
                    }
                    
                    VStack{
                        HStack(spacing: 5){
                            Image(systemName: "lock.fill")
                                .foregroundStyle(.black)
                            TextField("", text: $viewModel.password)
                                .foregroundStyle(.black)
                            
                                
                        
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .background(.white)
                        .cornerRadius(15)
                        .padding(.leading)
                        .padding(.trailing)
    
                    }
                    
                }
                .foregroundStyle(.black)
                //SignUpButton
                Button(action: {
                    print("Username and password =>", viewModel.emailInput, viewModel.password)
                
                 
                   
                }, label: {
                    Text("Sign In")
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .background(.white)
                        .cornerRadius(15)
                        .padding()
                        .tint(.black)
                        .font(.custom("Poppins-Medium", size: 18))
                })
                
                VStack{
                        HStack {
                            Text("Don't have an account?")
                            Text("Sign Up")
                                .underline(true)
                        }
                        .onTapGesture {
                            withAnimation(.spring) {
                                authMode = .signUp
                            }
                        }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 9)
                .padding(.leading, 19)
                .font(.custom("Poppins-Medium", size: 18))
                .foregroundStyle(.white)
               
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    LoginView(authMode: .constant(.signIn))
}
