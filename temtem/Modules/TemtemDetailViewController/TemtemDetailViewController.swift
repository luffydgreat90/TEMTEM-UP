//
//  TemtemDetailViewController.swift
//  temtem
//
//  Created by marlon von ansale on 02/11/2022.
//

import Combine
import UIKit

final class TemtemDetailViewController: BaseViewController<TemtemDetailView, TemtemDetailViewModel> {
    private let cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    func setupUI() {
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.title = viewModel.temtemViewModel.numberLabel
        self.customView.nameLabel.text = viewModel.temtemViewModel.temtemName
        self.customView.imageView.loadURL(url: viewModel.temtemViewModel.largeIcon)
        self.customView.typesStackView.setupTypes(temtemTypes: viewModel.temtemViewModel.types)

    }
}
