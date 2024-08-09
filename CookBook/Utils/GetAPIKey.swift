//
//  GetAPIKey.swift
//  CookBook
//
//  Created by Manu on 2024-08-09.
//

import Foundation


struct GetAPIKey {
    static func getAPIKey() -> String? {
        guard let apiKey = ConfigLoader.loadConfig()?.SpoonacularAPIKey else {
            return nil
        }
        
        
        return apiKey
    }
}
