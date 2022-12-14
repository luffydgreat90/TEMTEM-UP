//
//  TemtemListSnapshotTests.swift
//  temtemTests
//
//  Created by Marlon Ansale on 12/17/22.
//

import XCTest
import temtem
import UIKit

final class TemtemListSnapshotTests: XCTestCase {
    private func makeSUT() -> TemtemListViewController {
        let sut = TemtemListFactory.createTemtemListViewController(
            temtemService: MockTemtemService(),
            imageLoader: loadImageDataPublisher(from:),
            selection: { _ in })
        sut.loadViewIfNeeded()
        return sut
    }
    
    func test_view_with_empty_result(){
        let sut = makeSUT()
        let snapshot = sut.snapshot(for: SnapshotConfiguration.iPhone12(style: .dark))
        
        assert(snapshot: snapshot, named: "EMPTY_LIST_SNAPSHOT")
    }
    
    func test_view_with_results(){
        let sut = makeSUT()
        sut.display(list: [mockTemtemViewModel1,mockTemtemViewModel2])
        let snapshot = sut.snapshot(for: SnapshotConfiguration.iPhone12(style: .dark))
        
        assert(snapshot: snapshot, named: "TEMTEM_LIST_SNAPSHOT")
    }
    
    func test_view_with_error_result(){
        let sut = makeSUT()
        sut.customView.displayError(message: "TEST ERROR")
        let snapshot = sut.snapshot(for: SnapshotConfiguration.iPhone12(style: .dark))
        
        assert(snapshot: snapshot, named: "TEST_ERROR_SNAPSHOT")
    }
}

extension UIViewController {
    func snapshot(for configuration: SnapshotConfiguration) -> UIImage {
        return SnapshotWindow(configuration: configuration, root: self).snapshot()
    }
}



struct SnapshotConfiguration {
    let size: CGSize
    let safeAreaInsets: UIEdgeInsets
    let layoutMargins: UIEdgeInsets
    let traitCollection: UITraitCollection
    
    static func iPhone12(style: UIUserInterfaceStyle, contentSize: UIContentSizeCategory = .medium) -> SnapshotConfiguration {
        return SnapshotConfiguration(
            size: CGSize(width: 390, height: 844),
            safeAreaInsets: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0),
            layoutMargins: UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16),
            traitCollection: UITraitCollection(traitsFrom: [
                .init(forceTouchCapability: .available),
                .init(layoutDirection: .leftToRight),
                .init(preferredContentSizeCategory: contentSize),
                .init(userInterfaceIdiom: .phone),
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .regular),
                .init(displayScale: 2),
                .init(displayGamut: .P3),
                .init(userInterfaceStyle: style)
            ]))
    }
}

private final class SnapshotWindow: UIWindow {
    private var configuration: SnapshotConfiguration = .iPhone12(style: .light)
    
    convenience init(configuration: SnapshotConfiguration, root: UIViewController) {
        self.init(frame: CGRect(origin: .zero, size: configuration.size))
        self.configuration = configuration
        self.layoutMargins = configuration.layoutMargins
        self.rootViewController = root
        self.isHidden = false
        root.view.layoutMargins = configuration.layoutMargins
    }
    
    override var safeAreaInsets: UIEdgeInsets {
        return configuration.safeAreaInsets
    }
    
    override var traitCollection: UITraitCollection {
        return UITraitCollection(traitsFrom: [super.traitCollection, configuration.traitCollection])
    }
    
    func snapshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds, format: .init(for: traitCollection))
        return renderer.image { action in
            layer.render(in: action.cgContext)
        }
    }
}

extension TemtemListViewController {
    public override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
        customView.tableView.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
    }
}
