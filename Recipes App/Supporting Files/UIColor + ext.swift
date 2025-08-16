//
//  UIColor + ext.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 16/08/25.
//

import UIKit

extension UIColor {
    
    // MARK: - Neutral
    static let neutral100 = UIColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    static let neutral90  = UIColor(#colorLiteral(red: 0.1882353127, green: 0.1882353127, blue: 0.1882353127, alpha: 1))
    static let neutral80  = UIColor(#colorLiteral(red: 0.282352984, green: 0.282352984, blue: 0.282352984, alpha: 1))
    static let neutral70  = UIColor(#colorLiteral(red: 0.3764705658, green: 0.3764705658, blue: 0.3764705658, alpha: 1))
    static let neutral60  = UIColor(#colorLiteral(red: 0.5686274767, green: 0.5686274767, blue: 0.5686274767, alpha: 1))
    static let neutral50  = UIColor(#colorLiteral(red: 0.5686274767, green: 0.5686274767, blue: 0.5686274767, alpha: 1))
    static let neutral40  = UIColor(#colorLiteral(red: 0.6627451181, green: 0.6627451181, blue: 0.6627451181, alpha: 1))
    static let neutral30  = UIColor(#colorLiteral(red: 0.7568628192, green: 0.7568628192, blue: 0.7568628192, alpha: 1))
    static let neutral20  = UIColor(#colorLiteral(red: 0.850980401, green: 0.850980401, blue: 0.850980401, alpha: 1))
    static let neutral10  = UIColor(#colorLiteral(red: 0.9450979829, green: 0.9450979829, blue: 0.9450979829, alpha: 1))
    static let white0     = UIColor(#colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1))
    
    // MARK: - Primary
    static let primary100 = UIColor(#colorLiteral(red: 0.4434945583, green: 0.1202185825, blue: 0.1199180111, alpha: 1))
    static let primary90  = UIColor(#colorLiteral(red: 0.5324526429, green: 0.1460558474, blue: 0.1440324783, alpha: 1))
    static let primary80  = UIColor(#colorLiteral(red: 0.6216382384, green: 0.1667983234, blue: 0.1684818566, alpha: 1))
    
    static let primary70  = UIColor(#colorLiteral(red: 0.7103556991, green: 0.1976051629, blue: 0.197004348, alpha: 1))
    static let primary60  = UIColor(#colorLiteral(red: 0.7952086926, green: 0.2189562619, blue: 0.2217570245, alpha: 1))
    static let primary50  = UIColor(#colorLiteral(red: 0.8841535449, green: 0.2446581125, blue: 0.2408704162, alpha: 1))
    static let primary40  = UIColor(#colorLiteral(red: 0.9097194672, green: 0.3965435624, blue: 0.3953644037, alpha: 1))
    static let primary30  = UIColor(#colorLiteral(red: 0.9311036468, green: 0.5461376309, blue: 0.5429483056, alpha: 1))
    static let primary20  = UIColor(#colorLiteral(red: 0.9519807696, green: 0.699465692, blue: 0.6963114142, alpha: 1))
    static let primary10  = UIColor(#colorLiteral(red: 0.9786372781, green: 0.8461352587, blue: 0.8487259746, alpha: 1))
    static let primary0   = UIColor(#colorLiteral(red: 0.9874649644, green: 0.9232621789, blue: 0.9244522452, alpha: 1))
    
    // MARK: - Secondary
    static let secondary100 = UIColor(#colorLiteral(red: 0.5022984743, green: 0.3046188951, blue: 0, alpha: 1))
    static let secondary90  = UIColor(#colorLiteral(red: 0.601213038, green: 0.369756043, blue: 0.00121992745, alpha: 1))
    static let secondary80  = UIColor(#colorLiteral(red: 0.7011116743, green: 0.4264241159, blue: 0, alpha: 1))
    static let secondary70  = UIColor(#colorLiteral(red: 0.8000289202, green: 0.491563797, blue: 0, alpha: 1))
    static let secondary60  = UIColor(#colorLiteral(red: 0.8999177814, green: 0.5482232571, blue: 0, alpha: 1))
    static let secondary50  = UIColor(#colorLiteral(red: 0.9988374114, green: 0.6133651137, blue: 0, alpha: 1))
    static let secondary40  = UIColor(#colorLiteral(red: 0.9987997413, green: 0.651126802, blue: 0.104943864, alpha: 1))
    static let secondary30  = UIColor(#colorLiteral(red: 1, green: 0.7299690843, blue: 0.3002416492, alpha: 1))
    static let secondary20  = UIColor(#colorLiteral(red: 0.9988898635, green: 0.8083916306, blue: 0.5017971396, alpha: 1))
    static let secondary10  = UIColor(#colorLiteral(red: 0.9999813437, green: 0.8820154071, blue: 0.6999102235, alpha: 1))
    static let secondary0   = UIColor(#colorLiteral(red: 0.9990379214, green: 0.9594327807, blue: 0.9039080143, alpha: 1))
    
    // MARK: - Rating
    static let rating100 = UIColor(#colorLiteral(red: 0.9995872378, green: 0.7135206461, blue: 0.3790938854, alpha: 1))
    
    // MARK: - Error
    static let error100 = UIColor(#colorLiteral(red: 0.9314679503, green: 0.07252002507, blue: 0.2001981437, alpha: 1))
    static let error10  = UIColor(#colorLiteral(red: 0.990660727, green: 0.9068546891, blue: 0.9213654399, alpha: 1))
    
    // MARK: - Success / Green
    static let success100 = UIColor(#colorLiteral(red: 0.1898103952, green: 0.6920667887, blue: 0.342376411, alpha: 1))
    static let success10  = UIColor(#colorLiteral(red: 0.8092295527, green: 0.9251121879, blue: 0.8411361575, alpha: 1))
    
    // MARK: - Helper init from hex
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255
        let b = CGFloat(rgb & 0x0000FF) / 255

        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}
