//
//  UIViewExtension.swift
//  temtem
//
//  Created by marlon von ansale on 04/11/2022.
//

import UIKit.UIView

extension UIView {
    func addCornerRadius(_ roundingCorners: CACornerMask, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = roundingCorners
    }

    func fadeIn(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
        alpha = 0
        isHidden = false
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 1 },
                       completion: { _ in
							if let complete = onCompletion { complete() }
                       })
    }
}
