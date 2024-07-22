//
//  HomeScreenView.swift
//  CookBook
//
//  Created by Manu on 2024-04-18.
//

import SwiftUI

// i know it is gonna take some lines uncessarly 
// but i like code with more lines
private func getDefaultAuthMode() -> AuthenticationType {
    let returnType: AuthenticationType = .signUp
    return returnType
}


enum AuthenticationType: Codable {
    case signIn
    case signUp
}

struct WelcomeView: View {
    @State private var emailInput    : String = ""
    @State private var passwordInput : String = ""
    
    @State private var authMode: AuthenticationType = getDefaultAuthMode()
    
    @ObservedObject var AuthManager = AuthenticationManager.shared
    
    var isSignedUp: Bool {
        return AuthManager.isSignedUp
    }
    
    var body: some View {
        VStack{
            if authMode == .signUp {
                RegisterView(authMode: $authMode)
                    .transition(.blurReplace)
                
            }else{
                LoginView(authMode: $authMode)
                    .transition(.blurReplace)
            }
        }
        .background(.akGreen)
    }
}


#Preview {
    WelcomeView()
}
