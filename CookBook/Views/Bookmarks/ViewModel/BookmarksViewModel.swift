//
//  BookmarksViewModel.swift
//  CookBook
//
//  Created by Manu on 2024-08-22.
//

import Foundation
import Firebase
import FirebaseFirestore
class BookmarksViewModel: ObservableObject {
    @Published var bookmarks: [FetchedRecipe] = []
    @Published var isFetching : Bool = false
    
    let db = Firestore.firestore()
    
    @MainActor
    func getBookmarks() async {
        let bookmarksCollection = db.collection("bookmarks")
        
        do {
            isFetching = true
            let snapshot = try await bookmarksCollection.getDocuments()
            self.bookmarks = try snapshot.documents.compactMap { document in
                try document.data(as: FetchedRecipe.self)
            }
            
            isFetching = false

        }catch{
            isFetching = false

            print("Error in fetching bookmarks \(error.localizedDescription)")
        }
        
    }
}
