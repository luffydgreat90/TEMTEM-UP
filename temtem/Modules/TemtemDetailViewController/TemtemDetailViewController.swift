//
//  TemtemDetailViewController.swift
//  temtem
//
//  Created by marlon von ansale on 02/11/2022.
//

import Combine
import UIKit

class TemtemDetailViewController: UIViewController {
    private(set) var temtemDetailViewModel: TemtemDetailViewModel
    private(set) var customView: TemtemDetailView
    let cancellable = Set<AnyCancellable>()

    init(temtemDetailView: TemtemDetailView,temtemDetailViewModel: TemtemDetailViewModel) {
        self.temtemDetailViewModel = temtemDetailViewModel
        self.customView = temtemDetailView
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
        view.backgroundColor = .systemBackground

        setupUI()
    }

    func setupUI() {
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.title = temtemDetailViewModel.temtemViewModel.temtemName
        self.customView.numberLabel.text = temtemDetailViewModel.temtemViewModel.numberLabel
        self.customView.imageView.loadURL(url: temtemDetailViewModel.temtemViewModel.largeIcon)
        self.customView.setupTypes(temtemTypes: temtemDetailViewModel.temtemViewModel.types)

    }
}
