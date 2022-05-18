//
//  Custom animations pop + push.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 02.04.2022.
//

import UIKit

class TransitionAnimateForCustonNavController: NSObject, UIViewControllerAnimatedTransitioning {

    private let animDuration: TimeInterval = 1
    static var presenting = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from) else {return}
        guard let destination = transitionContext.viewController(forKey: .to) else {return}
        
        transitionContext.containerView.backgroundColor = .white

        
        let rotateIn = CGAffineTransform(rotationAngle: -.pi/2)
        let rotateOut = CGAffineTransform(rotationAngle: .pi/2)
        
        destination.view.transform = TransitionAnimateForCustonNavController.presenting ? rotateIn : rotateOut
        
        
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        
        
        destination.view.layer.position = CGPoint(x:transitionContext.containerView.frame.width, y:0)

        transitionContext.containerView.addSubview(destination.view)
        
        
  
        UIView.animate(withDuration: animDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.9,
                       options: []) {
            
            switch TransitionAnimateForCustonNavController.presenting {
            case true:
                destination.view.transform = rotateIn
            case false:
                source.view.transform = rotateIn
            }
            destination.view.transform = .identity
        } completion: { finished in
            if finished && !transitionContext.transitionWasCancelled {
                if !TransitionAnimateForCustonNavController.presenting {
                    source.removeFromParent()
                }
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
