//
//  DebuggingSceneDelegate.swift
//  temtem
//
//  Created by Marlon Ansale on 12/17/22.
//

import UIKit
import TemtemFeed
import Combine

fileprivate func makeURL(_ str: String = "https://any-given-url.com") -> URL {
    URL(string: str)!
}

class DebuggingSceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let temtemService: TemtemService = TemtemServiceTest()
        let temtemListVC: TemtemListViewController = TemtemListFactory.createTemtemListViewController(temtemService: temtemService)
        
        let navigation =  CustomNavigationController(rootViewController: temtemListVC)

        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}

class TemtemServiceTest: TemtemService {
    func fetchAllTemtems() -> TemtemLoader {
        return Future { promise in
            let mockTemtemViewModel1 = TemtemViewModel(number: 1, temtemName: "Anahir", portraitWikiUrl: makeURL(), largeIcon: makeURL(), largeLumaIcon: makeURL(), numberLabel: "#1", gameDescription: "test description", types: [TemtemTypes.crystal], traits: ["Trauma","Flawed Crystal"], wikiUrl: "")

            let mockTemtemViewModel2 = TemtemViewModel(number: 2, temtemName: "Golzy", portraitWikiUrl: makeURL(), largeIcon: makeURL(), largeLumaIcon: makeURL(), numberLabel: "#2", gameDescription: "test description", types: [TemtemTypes.electric, TemtemTypes.melee], traits: ["Defuser","Voltaic Charge"], wikiUrl: "")
            
            promise(.success([mockTemtemViewModel1, mockTemtemViewModel2]))
            
        }.eraseToAnyPublisher()
    }
}

