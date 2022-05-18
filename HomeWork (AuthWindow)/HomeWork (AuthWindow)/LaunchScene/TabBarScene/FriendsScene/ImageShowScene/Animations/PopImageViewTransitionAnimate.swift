//
//  PopImageViewTransitionAnimate.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.04.2022.
//

import UIKit

final class PopImageViewTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration =  0.5
    
    var imageInitFrame = CGRect.zero
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let conteiner = transitionContext.containerView
        guard let fromView = transitionContext.viewController(forKey: .from) else {return}
        guard let toView = transitionContext.viewController(forKey: .to) else {return}

        fromView.view.alpha = 1
        toView.view.alpha = 0
        
        
        conteiner.addSubview(fromView.view)
        conteiner.addSubview(toView.view)
        
        
        UIView.animate(withDuration: self.duration,
                                delay: 0,
                                options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4) {
                fromView.view.alpha = 0
                toView.view.alpha = 1
            }
 
        } completion: { finished in
            
            transitionContext.completeTransition(true)
        }
    }
  
}
