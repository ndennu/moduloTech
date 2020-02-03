//
//  Animations.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 30/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import UIKit

class CustomAnimations {
    
    private init() {
        
    }
    
    static let shared = CustomAnimations()
    
    var viewAnimated = [UIView]()
    
    func shakeOnce(onView view: UIView, angle: Double = 5, duration: CFTimeInterval = 0.1) {
        
        stopAnimation(onView: view)
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.repeatCount = .infinity
        rotateAnimation.autoreverses = true
        rotateAnimation.fromValue = CGFloat(angle * Double.pi / 180 * -1)
        rotateAnimation.toValue = CGFloat(angle * Double.pi / 180)
        rotateAnimation.duration = duration
        view.layer.add(rotateAnimation, forKey: "transform.rotation")
        
        viewAnimated.append(view)
    }
    
    private func stopAnimation(onView view: UIView) {
        if let first = viewAnimated.first {
            first.layer.removeAllAnimations()
            viewAnimated.removeFirst()
        }
    }
    
    func stopAnimationOnSelf(view: UIView) {
        if viewAnimated.first == view {
            stopAnimation(onView: view)
        }
    }
}
