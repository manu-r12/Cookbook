//
//  RegisterUserViewModel.swift
//  CookBook
//
//  Created by Manu on 2024-05-16.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase
import Combine
import FirebaseAuth
import FirebaseFirestore




class RegisterUserViewModel: ObservableObject {
    
    @Published var emailInput : String = "test3@gmail.com"
    @Published var password   : String = "123123123123"
    @Published var username   : String = ""
    
    //  Initialize the firestore database
    let db = Firestore.firestore()
    
    
    
    //  Getting user data from combine that is subscribed to the auth manager class
    @Published var user: User?
    
    /// Delegate (Auth)
    weak var delegate: AuthenticationDelegate?
    
    
    init(){
        setUpSubscribers()
    }
    
    
    @Published var isSignedUp : Bool = false
    
    // Combine Cancellable for storing publisher data in the cancellable
    private var cancellableForUserSession = Set<AnyCancellable>()
    private var cancellableForUserData    = Set<AnyCancellable>()
    
    
    @Published var selectedImage: UIImage?
    
    
    @MainActor
    @Published var pickedItem: PhotosPickerItem? {
        
        didSet { Task {
            if let pickedItem,
               let data = try? await pickedItem.loadTransferable(type: Data.self){
                if let image = UIImage(data: data){
                    selectedImage = image
                }
            }
            pickedItem = nil
        }}
        
    }
    
    func completeUserSignUp() async {
        

        guard let userData = user else {
            print("Found No User Data (error from: 'completeUserSignUp() func'")
            return
        }
        guard let image = selectedImage else {
            print("there is no image selected (error from: 'completeUserSignUp() func'")
            return
        }
        // this will return the imageUrl that we can use as a ref in document collocations of "users"
        // like a pointer
        
        guard let imageUrl = try? await ImageUploader.uploadImage(withImage: image) else {
            print("Function Did not return the image url")
            return
        }
        
        let user = RegisterUserStruct(uid: userData.uid, 
                                      username: username,
                                      email: emailInput,
                                      profileImage: imageUrl
        )
        
        await uploadUserData(userData: user)
        
    }
    
    
    func createUser() {
        
        AuthenticationManager.shared.signUp(withEmail: emailInput, withPassword: password)
        
    }
    
    private func uploadUserData(userData: RegisterUserStruct ) async {
        
        guard let encodedData = try? Firestore.Encoder().encode(userData) else {return}
        do {
            try await Firestore.firestore().collection("users").document(userData.uid).setData(encodedData)
            print("Saved Successfully✅")
//            delegate?.didLoginSuccessFully(state: true)
            
            AuthenticationManager.shared.isLoggedIn = true
            
            
        }catch{
            print("Error occured in saving the data", error.localizedDescription)
        }
       
        
    }
    
    
    private func setUpSubsriberForUserSession() {
        
        AuthenticationManager.shared.$isSignedUp.sink { isSignUp in
            
            print("Combine: We got the value for isSignedUp -> ", isSignUp)
            self.isSignedUp = isSignUp
            
        }.store(in: &cancellableForUserSession)
        
    }
    
    private func setUpSubsriberForUserData() {
        
        AuthenticationManager.shared.$userSession.sink { user in
            
            print("Combine: Got the user data", user ?? "no user data (from optional)")
            self.user = user
            
        }.store(in: &cancellableForUserData)
        
    }
    
    private func setUpSubscribers() {
        
        setUpSubsriberForUserSession()
        setUpSubsriberForUserData()
    }
    
  
    
    
    
    
}


