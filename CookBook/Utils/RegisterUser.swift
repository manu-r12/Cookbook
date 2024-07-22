
import FirebaseFirestore



struct RegisterUser {
    
    static func registerUser(user: RegisterUserStruct) async throws {

        guard let userData = try? Firestore.Encoder().encode(user) else {return}
        
        
        try await Firestore.firestore().collection("users").document(user.uid).setData(userData)
        
        
    }
}
