//
//  AuthenticationManager.swift
//  CookBook
//
//  Created by Manu on 2024-04-18.
//

import Foundation
import FirebaseAuth
import SwiftUI
import FirebaseCore

enum errors: Error{
    case singUpError
}

//l3I0ZIMFJKat2ESImwwd2GvYBmj1 this is the uid for first testig user..
class AuthenticationManager: ObservableObject, AuthenticationDelegate {
  
    
    
    @Published var isLoggedIn  : Bool = false
    @Published var userSession : FirebaseAuth.User?
    @Published var isSigningUp : Bool = false
    @Published var isSignedUp  : Bool = false
    @Published var user        : User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        checkLoginStatus()
    }
    
    private func checkLoginStatus(){
        if self.userSession != nil {
            print("Current User is Not Nil")
            self.isLoggedIn = true
        }else{
            print("Current User is Nil")
            self.isLoggedIn = false
            
        }
    }
    
    // shared instance of this class / Singelton
    
    static let shared = AuthenticationManager()
    
    
    
    func 
    signUp(withEmail email: String,
           withPassword password: String
    )
    {
        print("Processing....")
        isSigningUp = true
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            // ...
            if let errorOccured = error{
                print("Error found during singing up", errorOccured.localizedDescription)
                return
            }
            if let authResult = authResult  {
                print("SuccessFully Logged In ✅")
                print("Here are the details => ",authResult.user)
                self.isSigningUp = false
                self.isSignedUp = true
                self.user = authResult.user
           
            }else{
                self.isSigningUp = false
                self.isSignedUp = false
            }
            
        }
    }
    
    func signIn(withEmail email: String, withPassword password: String){
        Auth.auth().signIn(withEmail: email, password: password) { Result, Error in
            
            if let error = Error {
                print("Error in Signing in => ", error.localizedDescription)
                return
            }
            
            if let authResult = Result {
                print("SuccessFully Logged In ✅")
                print("SuccessFully Logged In ✅")
                print("Here are the details => ",authResult.user)
                self.userSession = authResult.user
                self.isLoggedIn = true
            }
        }
    }
    
    func signOut() {
        
        do{
            try Auth.auth().signOut()
            isLoggedIn = false
        }catch{
            print("Error in signing out \(error.localizedDescription)")
        }
        
        
    }
    
    func didLoginSuccessFully(state: Bool) {
        print("Delegate called: State - \(state)")
        isLoggedIn = state
    }
    
}
