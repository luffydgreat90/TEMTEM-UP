//
//  UITableView+Deque.swift
//  temtem
//
//  Created by Marlon Ansale on 11/15/22.
//

import UIKit.UITableView

public extension UITableView {
    func register<T: UITableViewCell>(_ name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
    
}
