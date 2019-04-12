//
//  CustomTransitionManager.swift
//  pocket-ios-client
//
//  Created by Борис Павлов on 20/03/2019.
//  Copyright © 2019 Damien Inc. All rights reserved.
//

import UIKit

class CustomTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    //MARK: Properties
    var presenting = true
    
    //MARK: Methods
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
  
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        let offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
        
        if self.presenting {
            toView.transform = offScreenRight
        } else {
            toView.transform = offScreenLeft
        }
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.91, initialSpringVelocity: 0.91, options: [], animations: { () -> Void in
            if self.presenting {
                fromView.transform = offScreenLeft
            } else {
                fromView.transform = offScreenRight
            }
            toView.transform = CGAffineTransform.identity
        }) { (finished) -> Void in
            transitionContext.completeTransition(true)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}
