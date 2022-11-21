//
//  UIColorExtension.swift
//  temtem
//
//  Created by Marlon Ansale on 11/14/22.
//

import UIKit.UIColor

extension UIColor {
    static var background: UIColor {
        UIColor(named: "BackgroundColor") ?? .white
    }
    
    static var cellBackground: UIColor {
        UIColor(named: "CellBackgroundColor")  ?? .white
    }
    
    static var textColor: UIColor {
        UIColor(named: "TextColor")  ?? .black
    }
}
