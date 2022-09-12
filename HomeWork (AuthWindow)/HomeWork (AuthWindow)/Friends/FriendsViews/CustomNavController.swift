//
//  CustomNavController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 02.04.2022.
//

import UIKit

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
}

class CustomNavController: UINavigationController, UINavigationControllerDelegate {

    let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let edgePanGestureRecognazer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanGestureAction(_:)))
        edgePanGestureRecognazer.edges = .left
        self.view.addGestureRecognizer(edgePanGestureRecognazer)
    }
    
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .pop:
            TransitionAnimateForCustonNavController.presenting = false
            return PopImageViewTransitionAnimation()
        case .push:
            TransitionAnimateForCustonNavController.presenting = true
            return PushImageViewTransitionAnimation()
        case .none:
            return nil
        @unknown default:
            return nil
        }
    }
    
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    @objc private func edgePanGestureAction (_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveTransition.hasStarted = true
            self.popViewController(animated: true)
        case .changed:
            guard let width = recognizer.view?.bounds.width else {
                interactiveTransition.hasStarted = false
                interactiveTransition.cancel()
                return
            }
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / width
            let progress = max(0, min(1, relativeTranslation))
            interactiveTransition.update(progress)
            interactiveTransition.shouldFinish = progress > 0.2
        case .ended:
            interactiveTransition.hasStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()
        case .cancelled:
            interactiveTransition.hasStarted = false
            interactiveTransition.cancel()
        default:
            break
        }
    }
    

}
