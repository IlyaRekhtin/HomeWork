//
//  ImageViewTransitionAnimation.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.04.2022.
//

import UIKit

class PopImageViewTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration =  0.3
    
    var imageInitFrame = CGRect.zero

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let conteiner = transitionContext.containerView
        guard let fromView = transitionContext.viewController(forKey: .from) else {return}
        guard let toView = transitionContext.viewController(forKey: .to) as? ImageShowViewController else {return}

        toView.view.alpha = 0
        toView.firstImageView.layer.frame = imageInitFrame
        conteiner.addSubview(toView.view)
        
        UIView.animateKeyframes(withDuration: self.duration,
                                delay: 0,
                                options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4) {
                toView.view.alpha = 1
            }
 
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1) {
                toView.firstImageView.frame = CGRect(x: toView.view.layer.frame.minX, y: toView.view.layer.frame.minY, width: toView.view.layer.frame.width, height: toView.view.layer.frame.height)
            }
        } completion: { finished in
            
            transitionContext.completeTransition(true)
        }
    }
  
}
