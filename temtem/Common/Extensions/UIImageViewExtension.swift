//
//  UIImageViewExtention.swift
//  temtem
//
//  Created by marlon von ansale on 01/11/2022.
//

import UIKit.UIImageView

public extension UIImageView {

	func setImage(image:UIImage?){
		UIView.transition(with: self, duration: 0.3 , options: .transitionCrossDissolve, animations: {
            self.image = image
		}, completion: nil)
	}
    
}
