//
//  LaungeViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 01.04.2022.
//

import UIKit
import SnapKit

class LaunchViewController: UIViewController {

    var loadImage = LoadImage(frame: CGRect(x: 0, y: 0, width: 90, height: 65))
   
    private var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { _ in
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AuthViewController") as? AuthViewController else {return}
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        })
        
        
        
        self.view.addSubview(loadImage)
        loadImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(self.loadImage.frame.size)
        }
        
    }
    
    func animate() {
        
        let layer = CAShapeLayer()
        layer.path = CloudLoadImage.bezierPath.cgPath
        layer.lineWidth = 3
        layer.strokeColor = UIColor.systemGreen.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeStart = 0
        layer.strokeEnd = 1
        
        let strokeEndAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        let strokeStartAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        strokeStartAnimation.fromValue = -1
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        animationGroup.duration = 2
        animationGroup.repeatCount = 5
        layer.add(animationGroup, forKey: nil)
        
        loadImage.layer.addSublayer(layer)
        
        let point = CAShapeLayer()
        point.backgroundColor = UIColor.systemGreen.cgColor
        point.bounds = CGRect(x: 0, y: 0, width: 5, height: 5)
        point.cornerRadius = 2.5
        self.loadImage.layer.addSublayer(point)
        
        let animationFollowPoint = CAKeyframeAnimation(keyPath: #keyPath(CAScrollLayer.position))
        animationFollowPoint.path = CloudLoadImage.bezierPath.cgPath
        animationFollowPoint.calculationMode = .paced
        animationFollowPoint.duration = 2
        animationFollowPoint.repeatCount = 5
        
        point.add(animationFollowPoint, forKey: nil)
        
        
        
        
    }
    

}

