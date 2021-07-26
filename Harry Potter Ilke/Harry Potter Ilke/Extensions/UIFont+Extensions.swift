//
//  UIFont+Extensions.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 23.07.2021.
//

import UIKit

extension UIFont {

    class func avenirNextRegular(size: CGFloat) -> UIFont {
        return font(.avenirNextRegular, size: size)
    }

    class func avenirNextSemiBold(size: CGFloat) -> UIFont {
        return font(.avenirNextSemiBold, size: size)
    }

    private class func font(_ font: AppFonts, size: CGFloat) -> UIFont {
        UIFont(name: font.rawValue, size: size)!
    }

}
