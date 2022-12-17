//
//  SceneDelegateTests.swift
//  temtemTests
//
//  Created by Marlon Ansale on 12/17/22.
//

import XCTest
@testable import temtem

final class SceneDelegateTests: XCTestCase {

    func test_scene_configuration() throws {
        let sut = SceneDelegate()
        sut.window = UIWindow()
        sut.configureWindow()
        
        let rootViewController = sut.window?.rootViewController as? UINavigationController
        let topViewController = rootViewController?.topViewController
        
        XCTAssertNotNil(rootViewController)
        XCTAssertTrue(topViewController is TemtemListViewController, "Expected TemtemListView should be the root of navigation controller.")
    }

}
