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
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(urlSession: URLSession(configuration: .ephemeral))
    }()
    
    private lazy var navigationController = CustomNavigationController(
        rootViewController: TemtemListFactory.createTemtemListViewController(temtemService: TemtemServiceImplementation(httpClient:httpClient), selection: showTemtemDetails(temtemViewModel:)))
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        self.configureWindow()
    }
    
    func configureWindow(){
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func showTemtemDetails(temtemViewModel: TemtemViewModel) {
        let viewController: TemtemDetailViewController = TemtemDetailFactory.createTemtemDetailViewController(temtemViewModel: temtemViewModel)

        self.navigationController.pushViewController(viewController, animated: true)
    }

}
