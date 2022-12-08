//
//  NSLayoutConstraintExtension.swift
//  temtem
//
//  Created by Marlon Ansale on 12/8/22.
//

import UIKit.NSLayoutConstraint

public extension NSLayoutConstraint
{
    func withPriority(_ priority: Float) -> NSLayoutConstraint
    {
        self.priority = UILayoutPriority(priority)
        return self
    }
}
