//
//  HomeScreenView.swift
//  CookBook
//
//  Created by Manu on 2024-04-18.
//

import SwiftUI


enum AuthenticationType: Codable {
    case signIn
    case signUp
}

struct WelcomeView: View {
    @State private var emailInput: String = ""
    @State private var passwordInput: String = ""
    
    @State private var authMode: AuthenticationType = .signIn
    
    @ObservedObject var AuthManager = AuthenticationManager.shared
    
    var isSignedUp: Bool {
        return AuthManager.isSignedUp
    }
    
    var body: some View {
        ZStack{
            Image("welcomScreenBg")
                .resizable()
                .scaledToFill()
            
            VStack {
                VStack{
                    Text("Start cooking, Start exploring")
                        .font(.custom("NotoSans-SemiBold", size: 37))
                        .foregroundStyle(.white)
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                
                
                VStack(alignment: .leading,spacing: 19){
                    
                    
                    VStack{
                        HStack(spacing: 20){
                            Image(systemName: "envelope.fill")
                            TextField("Email", text: $emailInput)
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
                        HStack(spacing: 20){
                            Image(systemName: "lock.fill")
                            TextField("Password", text: $passwordInput)
                                
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
                    
                    if authMode == .signUp {
                        AuthManager.signUp(withEmail: emailInput, withPassword: passwordInput)
                    }else{
                        AuthManager.signIn(withEmail: emailInput, withPassword: passwordInput)
                    }
                   
                }, label: {
                    Text(authMode == .signUp ? "Sign Up" : "Sign In")
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .background(AuthManager.isSigningUp ? .gray : .white)
                        .cornerRadius(15)
                        .padding()
                        .tint(.black)
                        .font(.custom("NotoSans-Medium", size: 18))
                })
                
                VStack{
                    if authMode == .signIn {
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
                    }else{
                        HStack {
                            Text("Already have an account?")
                            Text("Sign In")
                                .underline(true)
                        }
                        .onTapGesture {
                            withAnimation(.spring) {
                                authMode = .signIn
                            }
                        }
                    }
                   
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 9)
                .padding(.leading, 19)
                .font(.custom("NotoSans-SemiBold", size: 18))
                .foregroundStyle(.white)
               
            }
        }
        .ignoresSafeArea(.all)
    }
}


#Preview {
    WelcomeView()
}
