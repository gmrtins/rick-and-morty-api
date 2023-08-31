//
//  Images.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 31/08/2023.
//

import Foundation
import UIKit

enum Images: String {
    case placeholder = "placeholder"
    case tv = "tv"
    case gender = "gender"
    case origin = "origin"
    case status = "status"
    
    var image: UIImage? {
        return UIImage(named: rawValue)
    }
}
