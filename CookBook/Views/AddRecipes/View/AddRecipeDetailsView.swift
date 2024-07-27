//
//  AddRecipeDetailsView.swift
//  CookBook
//
//  Created by Manu on 2024-04-20.
//

import SwiftUI
import PhotosUI

enum TimeUnit: String, CaseIterable {
    case minutes = "Minutes"
    case hours = "Hours"
}

enum QuantityUnit: String, CaseIterable {
    case cups = "Cups"
    case ounces = "Ounces"
    case grams = "Grams"
    case milliliters = "Milliliters"
    case liters = "Liters"
}


struct AddRecipeDetailsView: View {
    
    @State private var timeUnit: TimeUnit = .minutes
    @State var title: String = ""
    @State var quantity: String = ""
    @State var nameOfIngredient: String = ""
    @State var ingredients: [Ingredients] = []
    @State var instructionsText: String = ""
    @State var categoryInput: String = ""
    @State var preprationTime: String = ""
    @State var cookingTime: String = ""
    @State var category: [String] = []
    
    @State var categoriesSelected: Category = .all
    
    
    @State private var isKeyboardVisible: Bool = false
    @State var isCameraMenuOpen: Bool = false
    @State var isInstructionsInputOpen: Bool = false
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImage: UIImage?
    @State private var isImageGallaryOpen: Bool = false
    
    
    @Environment(\.dismiss) var dimissView
    
    @ObservedObject var viewModel = AddRecipeViewModel()
    
    
    
    @Environment(\.dismiss) var dismissView
    
    var body: some View {
        
        ZStack {
            
            VStack{
                ScrollView {
                    VStack{
                        HStack{
                            Button(action: { dismissView() }, label: {
                                Text("Cancel")
                                    .font(.custom("Poppins-Medium", size: 18))
                                    .foregroundStyle(Color(.white))
                                
                            })
                            Spacer()
                            Text("Add A Recipe")
                                .font(.custom("Poppins-SemiBold", size: 20))
                                .foregroundStyle(.akGreen)
                            
                            Spacer()
                            Button(action: {
                                
                                Task{
                                    try await viewModel.uploadRecipe (
                                        name: title,
                                        ingredients: ingredients,
                                        instructions: instructionsText,
                                        category: category,
                                        preprationTime: preprationTime,
                                        cookingTime: cookingTime
                                    )
                                    
                                    dismissView()
                                }
                                
                                
                           
                                
                            }, label: {
                                Text("Add")
                                    .font(.custom("Poppins-Medium", size: 18))
                                    .foregroundStyle(Color(.white))
                                
                            })
                        }
                        .padding()
                        
                        VStack{
                            VStack(alignment: .leading){
                                
                                HStack(spacing: 40){
                                    
                                    VStack{
                                        Button {
                                            isCameraMenuOpen.toggle()
                                        } label: {
                                            if let image = viewModel.selectedImage {
                                                Image(uiImage: image)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 90, height: 90)
                                                
                                                
                                            }else{
                                                Image(systemName: "photo.fill")
                                                    .imageScale(.large)
                                                    .frame(width: 90, height: 90)
                                                    .background(.akBg)
                                                    .foregroundStyle(.akGreen)
                                            }
                                            
                                        }
                                        
                                    }
                                    .popover(isPresented: $isCameraMenuOpen, attachmentAnchor: .point(.trailing), arrowEdge: .bottom,  content: {
                                        VStack(content: {
                                            Button(action: {
                                                isImageGallaryOpen.toggle()
                                            }, label: {
                                                HStack {
                                                    Image(systemName: "photo")
                                                        .foregroundStyle(.akGreen)
                                                    Text("Photos Library")
                                                        .font(.custom("Poppins-Regular", size: 18))
                                                        .foregroundStyle(.white)
                                                    
                                                }
                                                .padding()
                                            })
                                            Button(action: {
                                                isImagePickerPresented.toggle()
                                            }, label: {
                                                HStack {
                                                    Image(systemName: "camera")
                                                        .foregroundStyle(.akGreen)
                                                    Text("Open Camera")
                                                        .font(.custom("Poppins-Regular", size: 18))
                                                        .foregroundStyle(.white)
                                                }
                                                
                                                .padding()
                                            })
                                            
                                            
                                            
                                        })
                                        .padding()
                                        .frame(minWidth: 40, minHeight: 40)
                                        .presentationCompactAdaptation(.popover)
                                        
                                        
                                    })
                                    
                                    
                                    .clipShape(Circle())
                                    VStack(alignment: .leading){
                                        Text("Title or Name")
                                            .font(.custom("Poppins-Regular", size: 18))
                                        TextField(text: $title) {
                                            Text("Add a title")
                                                .font(.custom("Poppins-Regular", size: 21))
                                        }
                                    }
                                }
                                .padding(.leading)
                            }
                            .padding()
                            // Add iN
                            VStack(alignment: .leading, spacing: 15){
                                Text("Add Ingredients")
                                    .font(.custom("Poppins-Regular", size: 18))
                                
                                if !ingredients.isEmpty {
                                    
                                    ForEach(ingredients, id: \.self){ ing in
                                        
                                        VStack{
                                            HStack(spacing: 20){
                                                VStack{
                                                    Image(systemName: "carrot.fill")
                                                        .imageScale(.large)
                                                        .frame(width: 70, height: 70)
                                                        .background(.akBg)
                                                        .foregroundStyle(.akGreen)
                                                        .clipShape(Circle())
                                                    
                                                }
                                                
                                                
                                                VStack(alignment: .leading){
                                                    
                                                    HStack(alignment: .center){
                                                        VStack(alignment: .leading){
                                                            Text("\(ing.quantity)")
                                                                .font(.custom("Poppins-Regular", size: 18))
                                                            
                                                            
                                                            Text(ing.nameOfIngredient)
                                                                .font(.custom("Poppins-Regular", size: 18))
                                                        }
                                                        
                                                        Spacer()
                                                        
                                                        Button(action: {
                                                            
                                                            if  let index = ingredients.firstIndex(of: ing){
                                                                
                                                                withAnimation(.spring) {
                                                                    ingredients.remove(at: index)
                                                                }

                                                            }
                                                            
                                                            
                                                        }, label: {
                                                            Image(systemName: "x.circle")
                                                                .foregroundStyle(.akGreen)
                                                                .imageScale(.medium)
                                                        })
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                VStack{
                                    HStack(spacing: 20){
                                        VStack{
                                            Button(action: {
                                                if !quantity.isEmpty && !nameOfIngredient.isEmpty {
                                                    let ingredient = Ingredients(quantity: quantity, nameOfIngredient: nameOfIngredient)
                                                    withAnimation(.spring) {
                                                        ingredients.append(ingredient)
                                                    }
                                                }
                                                
                                                quantity = ""
                                                nameOfIngredient = ""
                                                
                                            }, label: {
                                                Image(systemName: "plus")
                                                    .imageScale(.large)
                                                    .frame(width: 70, height: 70)
                                                    .background(.akBg)
                                                    .foregroundStyle(.akGreen)
                                                    .clipShape(Circle())
                                            })
                                        }
                                        
                                        VStack(alignment: .leading){
                                            TextField(text: $quantity) {
                                                Text("Quantity")
                                                    .font(.custom("Poppins-Regular", size: 18))
                                            }
                                            TextField(text: $nameOfIngredient) {
                                                Text("Name of the Ingredien")
                                                    .font(.custom("Poppins-Regular", size: 18))
                                            }
                                        }
                                        
                                    }
                                }
                                
                                
                            }
                            .padding()
                            // Add Instructions
                            VStack(alignment: .leading, spacing: 15){
                                Text("Add Instructions")
                                    .font(.custom("Poppins-Regular", size: 18))
                                
                                
                                Text("Tap to add instructions..")
                                    .font(.custom("Poppins-Regular", size: 18))
                                    .padding()
                                    .foregroundStyle(Color(.systemGray2))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(.akBg))
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                    .onTapGesture {
                                        isInstructionsInputOpen.toggle()
                                    }
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            
                            //Add Catogories
                            VStack(alignment: .leading, spacing: 15){
                                Text("Add Category")
                                    .font(.custom("Poppins-Regular", size: 18))
                                // display categories list
                                if !category.isEmpty {
                                    HStack{
                                        ForEach(category , id: \.self){catg in
                                            Text(catg)
                                                .padding(9)
                                                .font(.custom("Poppins-Medium", size: 16))
                                                .background(.akGreen)
                                                .foregroundStyle(.white)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .onTapGesture {
                                                    withAnimation(.spring) {
                                                        if let index = category.firstIndex(of: catg){
                                                            
                                                            category.remove(at: index)
                                                            
                                                            
                                                        }
                                                    }
                                                }
                                        }
                                    }
                                    
                                }
                
                                // MARK: CategoriesView for selection
                                CategoriesSelectionView(category: $category)
                                
                            }
                            .padding()
                            
                            
                            //Add prepartion time
                            
                            VStack(alignment: .leading, spacing: 15){
                                Text("Add Durations")
                                    .font(.custom("Poppins-Regular", size: 18))
                                // prepration time picker(menu)
                                VStack{
                                    HStack {
                                        Text("Prepration Time")
                                            .font(.custom("Poppins-Regular", size: 17))
                                        Spacer()
                                        TextField(text: $preprationTime) {
                                            Text("20")
                                                .font(.custom("Poppins-Regular", size: 16))
                                            
                                        }
                                        .frame(width: 40)
                                        Spacer()
                                        Picker("Select Time Unit", selection: $timeUnit) {
                                            ForEach(TimeUnit.allCases, id: \.self) {
                                                Text($0.rawValue)
                                                    .font(.custom("Poppins-Regular", size: 16))
                                                    .foregroundStyle(.black)
                                            }
                                        }
                                        .pickerStyle(MenuPickerStyle())
                                        .tint(.akGreen)
                                    }
                                }
                                .padding()
                                .background(.akBg)
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                
                                
                                VStack{
                                    HStack {
                                        Text("Cooking Time")
                                            .font(.custom("Poppins-Regular", size: 17))
                                        Spacer()
                                        TextField(text: $cookingTime) {
                                            Text("20")
                                                .font(.custom("Poppins-Regular", size: 16))
                                            
                                        }
                                        .frame(width: 40)
                                        Spacer()
                                        Picker("Select Time Unit", selection: $timeUnit) {
                                            ForEach(TimeUnit.allCases, id: \.self) {
                                                Text($0.rawValue)
                                                    .font(.custom("Poppins-Regular", size: 16))
                                                    .foregroundStyle(.black)
                                            }
                                        }
                                        .pickerStyle(MenuPickerStyle())
                                        .tint(.akGreen)
                                    }
                                }
                                .padding()
                                .background(.akBg)
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                
                            }
                            .padding()
                        }
                    }
                }
            } 
            .photosPicker(isPresented: $isImageGallaryOpen, selection: $viewModel.pickedItem)
            .sheet(isPresented: $isInstructionsInputOpen, content: {
                AddInstructionsSheetView(text: $instructionsText)
                
            })
            .fullScreenCover(isPresented: $isImagePickerPresented, content: {
                ImagePicker(delegate: viewModel).ignoresSafeArea()
            })
            .padding(.top, 50)
            .scrollIndicators(.hidden)
            .padding(.bottom, isKeyboardVisible ? 320 : 60)
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                withAnimation(.spring) {
                    isKeyboardVisible = true
                    print("Yes")
                }
                
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                withAnimation(.spring) {
                    isKeyboardVisible = false
                    print("Yes")
                }
            }
            
            
            //Loading State
            if  viewModel.isLoading {
                VStack(spacing: 40){
                    Image(systemName: "fork.knife.circle")
                        .font(.system(size: 80))
                        .foregroundStyle(.akGreen)
                    
                    Text("Please while we are uploading your recipe 🙃")
                        .font(.custom("Poppins-Medium", size: 17))
                        .frame(width: 300)
                        .multilineTextAlignment(.center)
                    
                    
                    ProgressView(value: viewModel.progress)
                                      .frame(width: 250)
                                      .progressViewStyle(LinearProgressViewStyle())
                                      .padding()
                                      .foregroundStyle(.akGreen)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.thinMaterial)
            }
           
        }
        
        .ignoresSafeArea()
    }
}

#Preview {
    AddRecipeDetailsView()
}
