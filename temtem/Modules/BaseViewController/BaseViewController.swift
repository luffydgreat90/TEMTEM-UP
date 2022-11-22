//
//  BaseViewController.swift
//  temtem
//
//  Created by Marlon Ansale on 11/22/22.
//

import UIKit

class BaseViewController<View:UIView, ViewModel>: UIViewController {
    let customView: View
    let viewModel: ViewModel
    
    init(view:View, viewModel:ViewModel){
        self.customView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
