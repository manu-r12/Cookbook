//
//  AddRecipePhotoDelegate.swift
//  CookBook
//
//  Created by Manu on 2024-04-21.
//

import Foundation
import UIKit


protocol AddRecipePhotoDelegate: AnyObject {
    func didSetThePhoto(_ image: UIImage)
}
