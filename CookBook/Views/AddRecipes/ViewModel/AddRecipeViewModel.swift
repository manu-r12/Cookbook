//
//  AddRecipeViewModel.swift
//  CookBook
//
//  Created by Manu on 2024-04-21.
//

import Foundation
import UIKit
import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseCore
import FirebaseStorage
import FirebaseAuth
import Combine

struct ImagePicker: UIViewControllerRepresentable {
    
    var delegate: AddRecipePhotoDelegate
    
    init(delegate: AddRecipePhotoDelegate) {
        self.delegate = delegate
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, delegate: delegate)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parent: ImagePicker
    var delegate: AddRecipePhotoDelegate
    
    init(parent: ImagePicker, delegate: AddRecipePhotoDelegate) {
        self.parent = parent
        self.delegate = delegate
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            delegate.didSetThePhoto(uiImage)
            print("Called function")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}




class AddRecipeViewModel: ObservableObject, AddRecipePhotoDelegate {
    
    
    @Published var selectedImage: UIImage?
    @Published var currentUser: FirebaseAuth.User?
    @Published var isLoading:Bool = false
    @Published var progress: Float = 0.0
    
    var cancellable = Set<AnyCancellable>()
    
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
    
    
    init(){
        setUpSubscriberForCurrentUser()
    }
    
    
    private func setUpSubscriberForCurrentUser() {
        AuthenticationManager.shared.$userSession.sink { user in
            guard let user = user else {
                print("Could'nt fetch the user from userSession")
                return
            }
            self.currentUser = user
            print("Got the user id => \(self.currentUser?.uid)")
            
        }.store(in: &cancellable)
    }
    
    
    func didSetThePhoto(_ image: UIImage) {
        selectedImage = image
    }
    
    
    func uploadImage() async throws -> String? {
        guard let imageData = selectedImage?.jpegData(compressionQuality: 0.30) else {
            print("No Image")
            return nil
        }
        let fileName = UUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "/recipe_images/\(fileName)")
        
        do{
            let _ =  try await storageRef.putDataAsync(imageData)
            let url = try await storageRef.downloadURL()
            return url.absoluteString
            
        }catch{
            print(error)
            return nil
        }
    }
    
    @MainActor
    func uploadRecipe(name: String, ingredients: [Ingredients], instructions: String, category: [String], preprationTime:
                      String, cookingTime: String) async throws {
        
        guard let uid = currentUser?.uid else {
            print("Couldn't get the uid")
            return
        }
        isLoading = true
        guard let imageUrl = try await uploadImage() else {
            print("Could'nt get the url")
            return
        }
        
        let recipe = RecipeModel(id: UUID(), name: name, imageUrl: imageUrl, ingredients: ingredients, instructions: instructions, category: category, preprationTime: preprationTime, cookingTime: cookingTime)
        
        guard let recipeData = try? Firestore.Encoder().encode(recipe) else {return}
        
        
        try await Firestore.firestore().collection("recipes").document(uid).setData(["recipesArray": recipeData])
        
        isLoading = false
        print("Done...")
        
        
        
    }
    
}
