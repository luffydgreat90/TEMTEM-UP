//
//  UITableView+Deque.swift
//  temtem
//
//  Created by Marlon Ansale on 11/15/22.
//

import UIKit.UITableView

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
    
}
