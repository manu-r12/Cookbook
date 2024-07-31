//
//  IngredinetsFinderView.swift
//  CookBook
//
//  Created by Manu on 2024-04-20.
//

import SwiftUI

struct IngredinetsFinderView: View {
    
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
                                VStack(alignment: .leading){
                                    HStack{
                                        Image(systemName: "camera")
                                            .font(.system(size: 28))
                                        Spacer()
                                        Image(systemName: "arrow.up.right")

                                    }
                                    .font(.system(size: 28))

                                    Spacer()
                                    Text("Search By Image in real time")
                                        .font(.custom("Poppins-Medium", size: 20))
                                        .frame(width: 140, alignment: .leading)
                                }
                                .padding(20)
                                .frame(width: 170, height: 240)
                                .foregroundStyle(.white)
                                .background(Color.indigo)
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                
                                VStack(spacing: 10){
                                    VStack(alignment: .leading){
                                        HStack{
                                            Image(systemName: "takeoutbag.and.cup.and.straw")
                                            Spacer()
                                            Image(systemName: "arrow.up.right")
                                            
                                        }
                                        .font(.system(size: 21))
                                        
                                        Spacer()
                                        
                                        Text("Search By Ingredients")
                                            .font(.custom("Poppins-Medium", size: 15))
//                                            .frame(width: /*130*/)
                                        
                                    }
                                    .padding(20)
                                    .frame(width: 170, height: 115)
                                    .background(.akGreen)
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                    
                                    VStack(alignment: .leading){
                                        HStack{
                                            Image(systemName: "magnifyingglass")
                                            Spacer()
                                            Image(systemName: "arrow.up.right")
                                            
                                        }
                                        .font(.system(size: 21))
                                        Spacer()

                                        Text("Search a specific recipe")
                                            .font(.custom("Poppins-Medium", size: 15))

                                    }
                                    .padding(20)
                                    .frame(width: 170, height: 115)
                                    .background(.akBg)
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                    
                                    
                                }
                                
                                
                            }
                        }
                        .padding(10)
                        .frame(width: 350, height: 360)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
//                .frame(maxWidth: .infinity, alignment: .leading)
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
    IngredinetsFinderView()
}
