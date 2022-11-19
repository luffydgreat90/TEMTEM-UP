//
//  HomeViewController.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import UIKit

class HomeViewController: UITabBarController {
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let temtemService = TemtemServiceImplementation()
        let temtemListViewModel = TemtemListViewModel(temtemService: temtemService)
        let tabOneViewController = TemtemListViewController(customView: TemtemListView(),viewModel: temtemListViewModel)
        
        let navigation = UINavigationController.init(rootViewController: tabOneViewController)
        
        let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))

        navigation.tabBarItem = tabOneBarItem
        
        self.viewControllers = [navigation]
    }

    
}
