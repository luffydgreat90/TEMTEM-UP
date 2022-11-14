//
//  UIImageViewExtention.swift
//  temtem
//
//  Created by marlon von ansale on 01/11/2022.
//

import UIKit
extension UIImageView {
	
	@discardableResult
	func loadURL(url:URL?) -> URLSessionDataTask? {
		
		guard let url = url else {
			return nil
		}
		
        let imageCache = NSCache<NSString,AnyObject>()
		
		if let image = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
			self.image = image
			return nil
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let data = data {
				DispatchQueue.main.async { [weak self] in
					if let image =  UIImage(data: data){
						imageCache.setObject(image, forKey: url.absoluteString as NSString)
						self?.setImage(image: image)
					}
				}
			}
		}
		task.resume()
		return task
		
	}
	
	func setImage(image:UIImage){
		UIView.transition(with: self, duration: 0.3 , options: .transitionCrossDissolve, animations: {
				   self.image = image
		}, completion: nil)
	}
    
}
