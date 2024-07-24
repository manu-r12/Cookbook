import SwiftUI

struct RecipeCircleImage: View {
    let imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            case .failure:
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
            @unknown default:
                Color.gray
            }
        }
    }
}
