import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class BookmarksViewModel: ObservableObject {
    @Published var bookmarks: [FetchedRecipe] = []
    @Published var isFetching: Bool = false
    
    let db = Firestore.firestore()
    
    @MainActor
    func getBookmarks() async {
        
        guard let user = AuthenticationManager.shared.userSession else {
            print("Could not get the user session data")
            return
        }
        
        let userBookmarksDocument = db.collection("bookmarks").document(user.uid)
        
        do {
            isFetching = true
            
            // Fetch the specific user's bookmarks document
            let document = try await userBookmarksDocument.getDocument()
            
            if let data = document.data(), let recipesData = data["recipes"] as? [[String: Any]] {
                let decoder = Firestore.Decoder()
                self.bookmarks = try recipesData.map { try decoder.decode(FetchedRecipe.self, from: $0) }
            } else {
                print("No bookmarks found for the user.")
                self.bookmarks = []
            }
            
            isFetching = false
            
        } catch {
            isFetching = false
            print("Error in fetching bookmarks: \(error.localizedDescription)")
        }
    }
}
