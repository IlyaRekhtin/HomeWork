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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        Api.shared.getFriends { friends in
            DispatchQueue.main.async {
                DataManager.data.myFriends = Array(friends.response.items)
            }
        }
        Api.shared.getGroups { groups in
            DispatchQueue.main.async {
                DataManager.data.myGroups = Array(groups.response.items)
            }
        }
        Api.shared.getNewsfeed { newsfeed in
            DispatchQueue.main.async {
                DataManager.data.myNews = Array(newsfeed.response.items)
                DataManager.data.usersForMyNews = Array(newsfeed.response.profiles)
//                DataManager.data.groupsForMyNews = Array(newsfeed.response.groups!)
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else {return}
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
   
}
//MARK: - set constraints
private extension LaunchViewController {
    func setConstraints(){
        self.view.addSubview(loadImage)
        loadImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(self.loadImage.frame.size)
        }
    }
}

//MARK: - animation methods
private extension LaunchViewController {
    func animate() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
            self.animateCALayer()
            self.loadImage.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } completion: { _ in
            self.loadImage.transform = .identity
        }
    }
    
    private  func animateCALayer() {
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
        loadImage.layer.addSublayer(layer)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        animationGroup.duration = 2
        animationGroup.repeatCount = .infinity
        layer.add(animationGroup, forKey: nil)
        
        let point = CAShapeLayer()
        point.backgroundColor = UIColor.systemGreen.cgColor
        point.bounds = CGRect(x: 0, y: 0, width: 5, height: 5)
        point.cornerRadius = 2.5
        self.loadImage.layer.addSublayer(point)
        
        let animationFollowPoint = CAKeyframeAnimation(keyPath: #keyPath(CAScrollLayer.position))
        animationFollowPoint.path = CloudLoadImage.bezierPath.cgPath
        animationFollowPoint.calculationMode = .paced
        animationFollowPoint.duration = 2
        animationFollowPoint.repeatCount = .infinity
        
        point.add(animationFollowPoint, forKey: nil)
    }
}
