//
//  UIColorExtension.swift
//  temtem
//
//  Created by Marlon Ansale on 11/14/22.
//

import UIKit.UIColor

public extension UIColor {
    static var background: UIColor {
        UIColor(named: "BackgroundColor") ?? .white
    }
    
    static var cellBackground: UIColor {
        UIColor(named: "CellBackgroundColor")  ?? .white
    }
    
    static var textColor: UIColor {
        UIColor(named: "TextColor")  ?? .black
    }
    
    static var buttonColor: UIColor {
        UIColor(named: "BlueColor")  ?? .blue
    }
    
    static var navigationColor: UIColor {
        UIColor(named: "BlueColor")  ?? .blue
    }
    
    static var textYellowColor: UIColor {
        UIColor(named: "TextYellowColor")  ?? .yellow
    }
}
