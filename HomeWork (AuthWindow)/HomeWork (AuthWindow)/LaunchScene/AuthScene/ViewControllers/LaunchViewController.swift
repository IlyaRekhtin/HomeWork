//
//  LaungeViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 01.04.2022.
//

import UIKit
import SnapKit
import RealmSwift
import SystemConfiguration

class LaunchViewController: UIViewController {
    
    private var loadImage = StartImage(frame: CGRect(x: 0, y: 0, width: 90, height: 65))
    private lazy var appImageView: UIImageView = {
        let appImageView = UIImageView(frame: CGRect(origin: .zero, size: .zero))
        appImageView.image = UIImage(named: "VKLable")
        appImageView.clipsToBounds = true
        appImageView.contentMode = .scaleAspectFit
        return appImageView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateCALayer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemMint
        makeConstraints()
    }
}


//MARK: - make constraints
private extension LaunchViewController {
    func makeConstraints(){
        self.view.addSubview(loadImage)
        loadImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
            make.size.equalTo(self.loadImage.frame.size)
        }
        self.view.addSubview(appImageView)
        appImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
    }
}

//MARK: - animation methods
private extension LaunchViewController {
    
    func animateCALayer() {
        DispatchQueue.global().async {
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
            animationGroup.repeatCount = .infinity
            
            DispatchQueue.main.async {
                layer.add(animationGroup, forKey: nil)
            }
            
            let point = CAShapeLayer()
            point.backgroundColor = UIColor.systemGreen.cgColor
            point.bounds = CGRect(x: 0, y: 0, width: 5, height: 5)
            point.cornerRadius = 2.5
            
            
            let animationFollowPoint = CAKeyframeAnimation(keyPath: #keyPath(CAScrollLayer.position))
            animationFollowPoint.path = CloudLoadImage.bezierPath.cgPath
            animationFollowPoint.calculationMode = .paced
            animationFollowPoint.duration = 2
            animationFollowPoint.repeatCount = .infinity
            
            DispatchQueue.main.async {
                point.add(animationFollowPoint, forKey: nil)
                self.loadImage.layer.addSublayer(layer)
                self.loadImage.layer.addSublayer(point)
            }
        }  
    }
}
