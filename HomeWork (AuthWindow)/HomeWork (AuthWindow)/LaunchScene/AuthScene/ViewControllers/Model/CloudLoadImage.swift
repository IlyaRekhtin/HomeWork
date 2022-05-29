//
//  CloudLoadImage.swift
//  VK(HomeWork)
//
//  Created by IlyaRekhtin on 01.04.2022.
//  Copyright © 2022 elixz57@gmail.com. All rights reserved.
//



import UIKit

class CloudLoadImage : NSObject {
    
    static var bezierPath: UIBezierPath = {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 67.47, y: 19.44))
        bezierPath.addCurve(to: CGPoint(x: 78.5, y: 37.29), controlPoint1: CGPoint(x: 73.93, y: 22.27), controlPoint2: CGPoint(x: 78.5, y: 29.19))
        bezierPath.addCurve(to: CGPoint(x: 61, y: 56.5), controlPoint1: CGPoint(x: 78.5, y: 47.9), controlPoint2: CGPoint(x: 70.66, y: 56.5))
        bezierPath.addLine(to: CGPoint(x: 25.47, y: 56.5))
        bezierPath.addCurve(to: CGPoint(x: 8.5, y: 37.29), controlPoint1: CGPoint(x: 16.05, y: 56.18), controlPoint2: CGPoint(x: 8.5, y: 47.71))
        bezierPath.addCurve(to: CGPoint(x: 26, y: 18.09), controlPoint1: CGPoint(x: 8.5, y: 26.68), controlPoint2: CGPoint(x: 16.34, y: 18.09))
        bezierPath.addCurve(to: CGPoint(x: 29.12, y: 18.39), controlPoint1: CGPoint(x: 27.07, y: 18.09), controlPoint2: CGPoint(x: 28.11, y: 18.19))
        bezierPath.addCurve(to: CGPoint(x: 34.13, y: 20.28), controlPoint1: CGPoint(x: 30.9, y: 18.74), controlPoint2: CGPoint(x: 32.58, y: 19.39))
        bezierPath.addCurve(to: CGPoint(x: 45.71, y: 7.37), controlPoint1: CGPoint(x: 35.78, y: 14.13), controlPoint2: CGPoint(x: 40.15, y: 9.27))
        bezierPath.addCurve(to: CGPoint(x: 50.92, y: 6.5), controlPoint1: CGPoint(x: 47.36, y: 6.8), controlPoint2: CGPoint(x: 49.11, y: 6.5))
        bezierPath.addCurve(to: CGPoint(x: 67.47, y: 19.44), controlPoint1: CGPoint(x: 58.59, y: 6.5), controlPoint2: CGPoint(x: 65.11, y: 11.91))
        bezierPath.close()
        return bezierPath
    }()
    
    //// Drawing Methods
     static func drawCanvas1() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!

        //// Color Declarations
        let color2 = UIColor(red: 0.632, green: 1.000, blue: 0.632, alpha: 1.000)

        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.lightGray
        shadow.shadowOffset = CGSize(width: 2, height: 2)
        shadow.shadowBlurRadius = 5

        //// Bezier Drawing
         let bezierPath = UIBezierPath()
         bezierPath.move(to: CGPoint(x: 67.47, y: 19.44))
         bezierPath.addCurve(to: CGPoint(x: 78.5, y: 37.29), controlPoint1: CGPoint(x: 73.93, y: 22.27), controlPoint2: CGPoint(x: 78.5, y: 29.19))
         bezierPath.addCurve(to: CGPoint(x: 61, y: 56.5), controlPoint1: CGPoint(x: 78.5, y: 47.9), controlPoint2: CGPoint(x: 70.66, y: 56.5))
         bezierPath.addLine(to: CGPoint(x: 25.47, y: 56.5))
         bezierPath.addCurve(to: CGPoint(x: 8.5, y: 37.29), controlPoint1: CGPoint(x: 16.05, y: 56.18), controlPoint2: CGPoint(x: 8.5, y: 47.71))
         bezierPath.addCurve(to: CGPoint(x: 26, y: 18.09), controlPoint1: CGPoint(x: 8.5, y: 26.68), controlPoint2: CGPoint(x: 16.34, y: 18.09))
         bezierPath.addCurve(to: CGPoint(x: 29.12, y: 18.39), controlPoint1: CGPoint(x: 27.07, y: 18.09), controlPoint2: CGPoint(x: 28.11, y: 18.19))
         bezierPath.addCurve(to: CGPoint(x: 34.13, y: 20.28), controlPoint1: CGPoint(x: 30.9, y: 18.74), controlPoint2: CGPoint(x: 32.58, y: 19.39))
         bezierPath.addCurve(to: CGPoint(x: 45.71, y: 7.37), controlPoint1: CGPoint(x: 35.78, y: 14.13), controlPoint2: CGPoint(x: 40.15, y: 9.27))
         bezierPath.addCurve(to: CGPoint(x: 50.92, y: 6.5), controlPoint1: CGPoint(x: 47.36, y: 6.8), controlPoint2: CGPoint(x: 49.11, y: 6.5))
         bezierPath.addCurve(to: CGPoint(x: 67.47, y: 19.44), controlPoint1: CGPoint(x: 58.59, y: 6.5), controlPoint2: CGPoint(x: 65.11, y: 11.91))
         bezierPath.close()
        
        context.saveGState()
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        color2.setStroke()
        bezierPath.lineWidth = 3
        bezierPath.lineCapStyle = .round
        bezierPath.lineJoinStyle = .round
        bezierPath.stroke()
        context.restoreGState()
    }
    
    

}

class LoadImage: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        CloudLoadImage.drawCanvas1()
    }
}
