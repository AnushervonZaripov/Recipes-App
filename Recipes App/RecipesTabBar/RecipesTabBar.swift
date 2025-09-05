//
//  RecipesTabBar.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 18/08/25.
//

import UIKit

class RecipesTabBar: UITabBar {
    
    private var shapeLayer: CAShapeLayer?

    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
     
        if let middleButton = self.subviews.first(where: { $0 is UIButton }) as? UIButton {
            let pointForMiddleButton = middleButton.convert(point, from: self)
            
            if middleButton.bounds.contains(pointForMiddleButton) {
                return middleButton
            }
        }
        return super.hitTest(point, with: event)
    }
    
    private func addShape() {
       
        self.shapeLayer?.removeFromSuperlayer()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.neutral10.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
 
        shapeLayer.shadowColor = UIColor(red: 0x6C / 255.0, green: 0x6C / 255.0, blue: 0x6C / 255.0, alpha: 0.08).cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: -1)
        shapeLayer.shadowOpacity = 1.0
        shapeLayer.shadowRadius = 8
        
        self.shapeLayer = shapeLayer
        self.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2

        path.move(to: CGPoint(x: 0, y: 0))
    
        path.addLine(to: CGPoint(x: (centerWidth - 55), y: 0))
        
        path.addCurve(
            to: CGPoint(x: centerWidth, y: 35),
            controlPoint1: CGPoint(x: (centerWidth - 25), y: 0),
            controlPoint2: CGPoint(x: centerWidth - 30, y: 35)
        )
        
        path.addCurve(
            to: CGPoint(x: (centerWidth + 55), y: 0),
            controlPoint1: CGPoint(x: centerWidth + 30, y: 35),
            controlPoint2: CGPoint(x: (centerWidth + 25), y: 0)
        )
        
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }
}
