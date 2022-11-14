//
//  AppDelegate.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import CoreData
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
		self.window = UIWindow(frame: UIScreen.main.bounds)
		
		let homeViewController = HomeViewController()
		window?.rootViewController = homeViewController
		window?.makeKeyAndVisible()
		
        return true
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "temtem")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


// SETUP WITHOUT USING XIB OR STORYBOARD
//func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//	if let windowScene = scene as? UIWindowScene {
//		let window = UIWindow(windowScene: windowScene)
//		window.rootViewController = MyCustomViewController()
//		self.window = window
//		window.makeKeyAndVisible()
//	}
//}
