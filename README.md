

# 🍳 Cookbook AI


![RecipeDetailsView_UserRecipes](https://github.com/user-attachments/assets/7975050a-7e38-4520-860f-8574a5f5afd2)
**Cookbook AI** is an iOS application that helps users find recipes based on the ingredients they have available. With features to save and share recipes, it's designed to make meal planning and cooking more convenient and enjoyable.

## 📱 Features

- **AI Recipe Assistant**  
  Get tailored recipe suggestions based on the ingredients you have. Just enter your ingredients, and Cookbook AI will show you the recipes that you can make right now with the matching ingredients.

- **Recipe Management**  
  Save your favorite recipes for easy access and share them with others. Manage your recipe collection effortlessly.

- **Bookmark**  
  Bookmark your favorite recipe or the recipe you cook more often.

- **User Authentication**  
  Securely log in and register with Firebase Authentication to keep your personal data and recipes protected.

- **Data Storage**  
  Store and retrieve recipes using Firebase Firestore, ensuring that your recipe collection is always accessible and up-to-date.

# 📖 What I Learned

Working on Cookbook AI helped me enhance my skills in multiple areas of iOS development:

### MVVM Architecture
Implemented the Model-View-ViewModel (MVVM) architecture for better code structure, separation of concerns, and maintainability. This architectural pattern improved how data flows between the UI and backend services.

### Enums for Clean Code
Used enums extensively to handle various states and cases throughout the application, making the codebase more organized, type-safe, and scalable.

### Unit and UI Testing
Implemented thorough testing for both individual components and the overall user interface. This includes writing unit tests for the business logic as well as UI tests to ensure a smooth user experience.

### Dependency Injection
Learned the best practices for managing dependencies in Swift, making the code more modular, testable, and easier to refactor.

### Asynchronous Programming with Swift's async/await
Utilized async/await patterns for making API calls and interacting with Firebase, improving code readability and error handling.

### SwiftUI
Built an intuitive and interactive UI using SwiftUI, including custom views and seamless animations to enhance user experience.


## 🛠️ Technologies Used

- **Swift**  
  Utilized for building the iOS application, taking advantage of its robust features and modern syntax.
  
- **Swift UI**  
  Used the modern Swift UI Framework for building appealing user interface.

- **Core ML**  
  Converted the trained model to Core ML for efficient detection on iphone.

- **KingFisher**  
 for image loading and caching.

- **Firebase**  
  Employed for user authentication, real-time data storage (Firestore), and analytics to enhance the app experience.
  
## 🛠️ API and other stuff Used  

- **Spooncular API**  
  for fetching recipe details and the recipe data.

## 🚀 Getting Started

To get started with **Cookbook AI**, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/cookbook-ai.git
2. **Opne the project**
   ```bash
    open CookbookAI.xcodeproj
