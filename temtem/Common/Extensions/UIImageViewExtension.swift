//
//  UIImageViewExtention.swift
//  temtem
//
//  Created by marlon von ansale on 01/11/2022.
//

import UIKit.UIImageView

public extension UIImageView {
    
	@discardableResult
	func loadURL(url:URL?) -> URLSessionDataTask? {
		
		guard let url = url else {
			return nil
		}
        
        let imageCache = NSCache<NSURL,UIImage>()
		
		if let image = imageCache.object(forKey: url as NSURL)  {
			self.image = image
			return nil
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let data = data, let image =  UIImage(data: data) {
				DispatchQueue.main.async { [weak self] in
					imageCache.setObject(image, forKey: url as NSURL)
                    self?.setImage(image: image)
                }
            }
        }
		
		task.resume()
		return task
	}
	
	func setImage(image:UIImage?){
		UIView.transition(with: self, duration: 0.3 , options: .transitionCrossDissolve, animations: {
            self.image = image
		}, completion: nil)
	}
    
}
