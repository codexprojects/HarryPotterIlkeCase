//
//  UIFont+Extensions.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 23.07.2021.
//

import UIKit

extension UIFont {

    class func AvenirNextRegular(size: CGFloat) -> UIFont {
        return font(.AvenirNextRegular, size: size)
    }
    
    class func AvenirNextSemiBold(size: CGFloat) -> UIFont {
        return font(.AvenirNextSemiBold, size: size)
    }

    private class func font(_ font: AppFonts, size: CGFloat) -> UIFont {
        UIFont(name: font.rawValue, size: size)!
    }
    
}

