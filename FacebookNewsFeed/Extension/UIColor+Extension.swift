//
//  UIColor+Extension.swift
//  FacebookNewsFeed
//
//  Created by Ting on 2023/8/16.
//

import Foundation
import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
