//
//  RecipesTabBar.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 18/08/25.
//

import UIKit

class RecipesTabBar: UITabBar {
    
    // CAShapeLayer, который будет рисовать нашу форму
    private var shapeLayer: CAShapeLayer?
    
    // Этот метод будет вызываться, когда tab bar будет отрисовываться
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    // Переопределяем hitTest, чтобы клики по кнопке работали
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // Если точка находится за пределами tab bar, но внутри кнопки, мы все равно обрабатываем ее
        if let middleButton = self.subviews.first(where: { $0 is UIButton }) as? UIButton {
            let pointForMiddleButton = middleButton.convert(point, from: self)
            
            if middleButton.bounds.contains(pointForMiddleButton) {
                return middleButton
            }
        }
        return super.hitTest(point, with: event)
    }
    
    private func addShape() {
        // Удаляем предыдущий слой, чтобы избежать наложения
        self.shapeLayer?.removeFromSuperlayer()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.neutral10.cgColor // Цвет границы
        shapeLayer.fillColor = UIColor.white.cgColor // Цвет фона
        shapeLayer.lineWidth = 1.0
        
        // Тень для нашего слоя
        // Тень для нашего слоя
        shapeLayer.shadowColor = UIColor(red: 0x6C / 255.0, green: 0x6C / 255.0, blue: 0x6C / 255.0, alpha: 0.08).cgColor // Цвет тени #6C6C6C с прозрачностью 8%
        shapeLayer.shadowOffset = CGSize(width: 0, height: -1) // Смещение тени: X=0, Y=-1
        shapeLayer.shadowOpacity = 1.0 // Так как прозрачность уже учтена в shadowColor
        shapeLayer.shadowRadius = 8 // Радиус размытия (Blur)
        
        self.shapeLayer = shapeLayer
        self.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    // Эта функция создаёт изогнутый путь для tab bar
    private func createPath() -> CGPath {
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        // Начало пути в левом нижнем углу
        path.move(to: CGPoint(x: 0, y: 0))
        
        // Линия до центрального выреза
        path.addLine(to: CGPoint(x: (centerWidth - 55), y: 0))
        
        // Создаем изогнутую дугу
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
        
        // Линия до правого верхнего угла
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }
}
