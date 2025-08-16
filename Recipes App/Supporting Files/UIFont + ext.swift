//
//  UIFont + ext.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 16/08/25.
//

import UIKit

extension UIFont {
 
    static func poppinsBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Poppins-Bold", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .bold)
        }
        return font
    }
    
    static func poppinsRegular(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Poppins-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        return font
    }
}
