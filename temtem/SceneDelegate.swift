//
//  SceneDelegate.swift
//  temtem
//
//  Created by Marlon Ansale on 12/17/22.
//

import UIKit
import Combine
import TemtemFeed

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private lazy var baseURL: URL = {
        URL(string: .urlBase)!
    }()
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(urlSession: URLSession(configuration: .ephemeral))
    }()
    
    private lazy var temtemService: TemtemService = {
        TemtemServiceImplementation(
            httpClient:httpClient,
            baseURL: baseURL)
    }()
    
    private lazy var imageDataService:ImageDataService = {
        ImageURLSessionDataService(httpClient: httpClient)
    }()
    
    private lazy var imageCacheService:ImageCacheService = {
        ImageNSCacheService()
    }()
    
    private lazy var navigationController = CustomNavigationController(
        rootViewController: TemtemListFactory.createTemtemListViewController(
            temtemService: temtemService,
            imageLoader: makeLocalImageLoaderWithRemoteFallback,
            selection: showTemtemDetails(temtemViewModel:)))
    
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
        let viewController: TemtemDetailViewController = TemtemDetailFactory.createTemtemDetailViewController(
            temtemViewModel: temtemViewModel,
            imageLoader: makeLocalImageLoaderWithRemoteFallback)

        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    private func makeLocalImageLoaderWithRemoteFallback(url: URL) -> AnyPublisher<Data,Error> {
        imageCacheService.retrieve(dataForURL: url)
            .fallback { [httpClient, imageCacheService] in
                httpClient
                    .dispatch(withURL: url)
                    .tryMap(ImageDataMapper.map)
                    .caching(to: imageCacheService, using: url)
                    .eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }

}
