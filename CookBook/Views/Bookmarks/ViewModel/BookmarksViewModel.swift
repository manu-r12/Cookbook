import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FetchedBookmarks: Codable {
    // either of this value can be null
    let recipes: [FetchedRecipe]?
    let userCreatedRecipes: [RecipeModel]?
}

class BookmarksViewModel: ObservableObject {
    @Published var bookmarks: FetchedBookmarks?
    @Published var isFetching: Bool = false
    
    private let db = Firestore.firestore()
    
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
            
            //TODO: we need to take care of the returning type
            // it may cause some crashing
            let data = try document.data(as: FetchedBookmarks.self)
            self.bookmarks = data
            
            
            print("Got the bookmarks data ", data)

            
            isFetching = false
            
        } catch {
            isFetching = false
            print("Error in fetching bookmarks: \(error.localizedDescription)")
        }
    }
}
