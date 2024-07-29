import SwiftUI
import Kingfisher

//VStack {
//    KFImage(URL(string: imageUrl))
//        .resizable()
//        .scaledToFit()
//        .frame(width: 200, height: 200)
//        .cornerRadius(10)
//        .shadow(radius: 10)
//    
//    Text("Kingfisher with SwiftUI")
//        .font(.headline)
//}
//.padding()

struct RecipeCircleImage: View {
    let imageUrl: String
    
    var body: some View {
        VStack{
            KFImage(URL(string: imageUrl))
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
            
            
            
        }
    }
}
