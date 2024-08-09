//
//  IngredinetsFinderView.swift
//  CookBook
//
//  Created by Manu on 2024-04-20.
//

import SwiftUI

struct IngredientsFInderOptionsView: View {
    
    @State var isCameraOpen: Bool = false
    @State var isSearchViewOpen: Bool = false
    
    let vm = IngredientsFinderOptionsViewModel()
    
    let IngredientsFinderVCWrapper = UIKitViewControllerWrapper(viewController: IngredientsFinderWithCameraViewController())
    
    var body: some View {
        VStack{
            VStack{
                Spacer()
                
                VStack(spacing: 0){
                    
                    VStack(alignment: .leading){
                        HStack(){
                            Text("Find recipes that you desire")
                                .font(.custom("Poppins-Medium", size: 31))
//                                .foregroundStyle(
//                                    LinearGradient(
//                                        colors: [.akGreen, .green],
//                                        startPoint: .topLeading,
//                                        endPoint: .bottomTrailing
//                                    )
//                                )
//                            
                            Spacer()
                            Image(systemName: "fork.knife.circle")
                                .font(.system(size: 58))
//                                .foregroundStyle(
//                                    LinearGradient(
//                                        colors: [.akGreen, .green],
//                                        startPoint: .topLeading,
//                                        endPoint: .bottomTrailing
//                                    )
//                                )
                        }
                    }
                    .padding([.horizontal],20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // MARK: Options Grid View
                    VStack(){
                        VStack{
                            
                            HStack(spacing: 10){
                                
                                LargeSizeOptionBox(
                                    title: "Search an image in real time",
                                    bgColor: .indigo,
                                    icon: "camera",
                                    action: {
                                        isCameraOpen.toggle()
                                    }
                                )
                                
                                VStack(spacing: 10){
                                    
                                    MediumSizeOptionBox(
                                        title: "Search By Ingredients",
                                        bgColor: .akGreen,
                                        icon: "takeoutbag.and.cup.and.straw",
                                        action: {
                                            print("Triggered By -> Search By Ingredients")
                                        }
                                    )
                                    
                                    MediumSizeOptionBox(
                                        title: "Search a specific recipe",
                                        bgColor: .akBg,
                                        icon: "magnifyingglass",
                                        action: {
                                            isSearchViewOpen.toggle()
                                        }
                                    )
                                }
                            }
                        }
                        .padding(10)
                        .frame(width: 350, height: 360)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .padding(.top, 45)
        }
        .fullScreenCover(isPresented: $isSearchViewOpen, content: {
            SearchRecipeByNameView(viewModel: vm)
        })
        .fullScreenCover(isPresented: $isCameraOpen, content: {
            IngredientsFinderVCWrapper
                .presentationBackground(.black)
        })
        .ignoresSafeArea()
    }
}
#Preview {
    IngredientsFInderOptionsView()
}
