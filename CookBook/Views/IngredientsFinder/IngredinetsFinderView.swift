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
        ZStack{
            ScrollView{
                VStack{
                    HStack(spacing: 20){
                        VStack(alignment: .leading, spacing: 15){
                            
                            Text("Find recipes with what you have left")
                                .font(.custom("Poppins-SemiBold", size: 25))
                                .frame(width: 250)
                        }
                        VStack{
                            Button(action: {
                                isCameraOpen.toggle()
                            }, label: {
                                Image(systemName: "camera.circle.fill")
                                    .font(.system(size: 60))
                                    .foregroundStyle(.akGreen)
                            })
                            
                        }
                    }
                    .padding()
                    
                }
                .padding(.top, 10)
                
                VStack{
                    VStack {
                        Text("Recent Discoveries")
                            .font(.custom("Poppins-Medium", size: 19))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    ForEach(DummyData().foods, id: \.self){food in
                        VStack{
                            HStack(spacing: 10){
                                Image(food.image)
                                    .resizable()
                                    .frame(width: 85, height: 85)
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(food.name)
                                            .font(.custom("Poppins-Medium", size: 17))
                                        Text("Matches 4 ingredients")
                                            .font(.custom("Poppins-Medium", size: 15))
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(8)
                        }
                        .background(.akBg)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .padding(.leading)
                        .padding(.trailing)
                    }
                }
                .scrollIndicators(.hidden)
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
