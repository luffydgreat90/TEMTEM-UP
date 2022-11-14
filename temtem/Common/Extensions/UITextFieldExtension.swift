//
//  UITextField.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import UIKit
import Combine

extension UITextField {

	var textPublisher: AnyPublisher<String, Never> {
		 NotificationCenter.default.publisher(
			 for: UITextField.textDidChangeNotification,
			 object: self
		 )
		 .compactMap { ($0.object as? UITextField)?.text }
		 .eraseToAnyPublisher()
	 }

}

