//
//  IngredinetsFinderView.swift
//  CookBook
//
//  Created by Manu on 2024-04-20.
//

import SwiftUI

struct IngredientsFInderOptionsView: View {
    
    @State var isCameraOpen: Bool = false
    
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
                            Spacer()
                            Image(systemName: "fork.knife.circle")
                                .font(.system(size: 58))
                        }
                    }
                    .padding([.horizontal],20)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    // MARK: Options Grid View
                    // TODO: Later this part of view will be refactored!!
                    VStack(){
                        VStack{
                            
                            HStack(spacing: 10){
                                
                                LargeSizeOptionBox(
                                    title: "Search an image in real time",
                                    bgColor: .indigo,
                                    icon: "camera",
                                    action: {
                                        
                                    }
                                )
                                
                                VStack(spacing: 10){
                                    
                                    MediumSizeOptionBox(
                                        title: "Search By Ingredients",
                                        bgColor: .akGreen,
                                        icon: "takeoutbag.and.cup.and.straw",
                                        action: {
                                            
                                        }
                                    )
                                    
                                    MediumSizeOptionBox(
                                        title: "Search a specific recipe",
                                        bgColor: .akBg,
                                        icon: "magnifyingglass",
                                        action: {
                                            
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
