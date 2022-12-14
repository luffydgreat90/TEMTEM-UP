//
//  TemtemDetailViewController.swift
//  temtem
//
//  Created by marlon von ansale on 02/11/2022.
//

import Combine
import UIKit

public final class TemtemDetailViewController: BaseViewController<TemtemDetailView, TemtemDetailViewModel> {
    private let cancellable = Set<AnyCancellable>()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupUI()
    }

    func setupUI() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = viewModel.temtemViewModel.numberLabel
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))

        backButton.tintColor = .textYellowColor
        self.navigationItem.leftBarButtonItem = backButton
        
        self.customView.nameLabel.text = viewModel.temtemViewModel.temtemName
        
        self.customView.imageView.loadImage(
            withURL: viewModel.temtemViewModel.largeIcon,
            imageLoader: self.viewModel.imageLoader)
        
        self.customView.typesStackView.setupTypes(
            temtemTypes: viewModel.temtemViewModel.types,
            imageLoader: self.viewModel.imageLoader)
        
        self.customView.textDetails.text = viewModel.temtemViewModel.gameDescription
        self.customView.traitsView.setupTraits(traits: viewModel.temtemViewModel.traits)
        self.customView.tvYieldView.setupYields(yields: viewModel.temtemViewModel.tvYields)
    }
}
