//
//  SettingsViewModel.swift
//  CookBook
//
//  Created by Manu on 2024-08-30.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase


class SettingsViewModel: ObservableObject {
    @Published var user: UserModel?
    
    @Published var username   : String = ""
    @Published var selectedImage: UIImage?
    
    @Published var isUploading = false
    
    
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
    
    
    
    @MainActor
    func fetchUserDetails() async {
        
        do {
            user = try await AuthenticationManager.shared.fetchUserDetails()
        
        }catch{
            print(
                "Error in fetching user details -> \(error.localizedDescription)"
            )
        }
        
    }
    
    // todo : please manu add some tests in the future
    
    @MainActor
    func uploadEditedInfo() async {
        
        let db = Firestore.firestore()
         
        guard let userdata = user else {
            return
        }
        
        guard let image = selectedImage else {
            print("there is no image selected (error from: 'completeUserSignUp() func'")
            return
        }
        // this will return the imageUrl that we can use as a ref in document collocations of "users"
        // like a pointer
        isUploading = true
        guard let imageUrl = try? await ImageUploader.uploadImage(withImage: image) else {
            print("Function Did not return the image url")
            return
            
        }
        
        let userRef = db.collection("users").document(userdata.uid)

        do {
            try await userRef.updateData([
                "username": username,
                "profileImage": imageUrl
            ])
            print("User profile updated successfully!")
            isUploading = false
        } catch {
            isUploading = false
            print("Failed to update user profile: \(error.localizedDescription)")
           
        }
        
    }
}
