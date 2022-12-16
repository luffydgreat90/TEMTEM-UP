//
//  BaseViewController.swift
//  temtem
//
//  Created by Marlon Ansale on 11/22/22.
//

import UIKit

public class BaseViewController<View:BaseView, ViewModel>: UIViewController {
    public let customView: View
    public let viewModel: ViewModel
    
    init(view:View, viewModel:ViewModel){
        self.customView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        super.loadView()
        self.view = self.customView
        self.customView.setupView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

    }

}
