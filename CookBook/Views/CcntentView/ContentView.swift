//
//  ContentView.swift
//  CookBook
//
//  Created by Manu on 2024-04-18.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var AuthManager = AuthenticationManager.shared
    var body: some View {
        Group{
            if AuthManager.isLoggedIn {
                TabbarView()
            }else{
                WelcomeView()
            }
     
        }
    }
}

#Preview {
    ContentView()
}
