//
//  CustomNavigationController.swift
//  temtem
//
//  Created by Marlon Ansale on 11/23/22.
//

import UIKit

public final class CustomNavigationController: UINavigationController {
    public override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .navigationColor
                
        let titleAttribute = [NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 25, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.textYellowColor]
        appearance.titleTextAttributes = titleAttribute
        appearance.largeTitleTextAttributes = titleAttribute
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        
    }
    
}
