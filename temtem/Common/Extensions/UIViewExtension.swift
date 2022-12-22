//
//  UIViewExtension.swift
//  temtem
//
//  Created by marlon von ansale on 04/11/2022.
//

import UIKit.UIView

// MARK: - Layers
public extension UIView {
    
    func addSubviews(views:[UIView]){
        views.forEach { view in
            self.addSubview(view)
        }
    }
    
    func addCornerRadius(radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }

}

// MARK: - Animation
public extension UIView {
    func fadeIn(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
        alpha = 0
        isHidden = false
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 1 },
                       completion: { _ in
                            if let complete = onCompletion { complete() }
                       })
    }
    
    func setIsHidden(_ hidden: Bool, _ duration: TimeInterval = 0.25, animated: Bool) {
        if animated {
            if isHidden, !hidden {
                alpha = 0.0
                isHidden = false
            }
            UIView.animate(withDuration: duration, animations: {
                self.alpha = hidden ? 0.0 : 1.0
            }, completion: { _ in
                self.isHidden = hidden
            })
        } else {
            isHidden = hidden
        }
    }
    
}
