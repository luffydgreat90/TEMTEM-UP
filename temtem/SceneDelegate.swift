//
//  SceneDelegate.swift
//  temtem
//
//  Created by Marlon Ansale on 12/17/22.
//

import UIKit
import TemtemFeed

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let temtemService: TemtemService = TemtemServiceImplementation()
        let temtemListVC: TemtemListViewController = TemtemListFactory.createTemtemListViewController(temtemService: temtemService)
        
        let navigation =  CustomNavigationController(rootViewController: temtemListVC)

        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    
    }
}
