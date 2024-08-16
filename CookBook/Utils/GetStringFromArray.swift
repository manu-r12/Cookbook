//
//  GetStringFromArray.swift
//  CookBook
//
//  Created by Manu on 2024-08-16.
//

import Foundation


enum GetStringFromArray {
    case withWhiteSpace(array: [String])
    case withoutWhiteSpace(Array: [String])
    
    
    var getString: String {
        switch self {
        case .withWhiteSpace(let arr):
            let formattedString =  arr.joined(separator: ", ")

            return formattedString
        case .withoutWhiteSpace(let arr):
            let formattedString =  arr.joined(separator: ",")
            
            return formattedString
        }
    }
    
}
