//
//  Bookmarks.swift
//  CookBook
//
//  Created by Manu on 2024-08-23.
//

import Foundation
import Firebase

struct Bookmarks {
    static func isRecipeBookmarked(documentId: String) async -> Bool {
        do {
            let db = Firestore.firestore()
            
            let documentSnapshot = try await db.collection("bookmarks").document(documentId).getDocument()
            
            // Check if the document exists
            if let data = documentSnapshot.data() , documentSnapshot.exists {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
        
    }
}

