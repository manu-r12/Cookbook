//
//  RegisterView.swift
//  CookBook
//
//  Created by Manu on 2024-04-18.
//

import SwiftUI


struct RegisterView: View {
    
    @Binding var authMode: AuthenticationType
    @StateObject var viewModel = RegisterUserViewModel()

    @State var isPresented: Bool = false
    
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
                    viewModel.createUser()
                 
                   
                }, label: {
                    Text("Sign Up")
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
                            Text("have an account?")
                            Text("Sign In")
                                .underline(true)
                        }
                        .onTapGesture {
                            withAnimation(.spring) {
                                authMode = .signIn
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
        .sheet(isPresented: $viewModel.isSignedUp, content: {
            RegisterUserNameView(
                viewModel: viewModel
            )
//            .presentationBackground(.black)
            .presentationDetents([.large])
        })
        .ignoresSafeArea(.all)
    }
}


#Preview {
   WelcomeView()
}
