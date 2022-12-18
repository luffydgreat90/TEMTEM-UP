//
//  AppDelegate.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import CoreData
import UIKit
import TemtemFeed

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        #if DEBUG
            configuration.delegateClass = DebuggingSceneDelegate.self
        #endif

        return configuration
    }
}
