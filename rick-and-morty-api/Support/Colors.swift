//
//  Colors.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 31/08/2023.
//

import Foundation
import UIKit

enum Colors: String {
    case backgroundColor = "backColor"
    case textColor = "textColor"
    case tint = "tintColor"
    
    var color: UIColor? {
        return UIColor(named: rawValue)
    }
}
