//
//  AuthenticationDelegate.swift
//  CookBook
//
//  Created by Manu on 2024-06-04.
//

import Foundation


protocol AuthenticationDelegate: AnyObject {
    func didLoginSuccessFully(state: Bool)
}



