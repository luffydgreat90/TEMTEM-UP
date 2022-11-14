//
//  TemtemCell.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import UIKit

final class TemtemCell: UITableViewCell {
    
    lazy var numLabel: UILabel = {
        let numLabel = UILabel()
        numLabel.textColor = .black
        numLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        numLabel.translatesAutoresizingMaskIntoConstraints = false
        return numLabel
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    let temtemImageView: UIImageView = {
        let temtemImageView = UIImageView()
        temtemImageView.backgroundColor = .none
        temtemImageView.contentMode = .scaleAspectFit
        temtemImageView.clipsToBounds = true
        temtemImageView.layer.masksToBounds = true
        temtemImageView.translatesAutoresizingMaskIntoConstraints = false
        return temtemImageView
    }()

    let containerView: UIStackView = {
        let containerView = UIStackView()
        containerView.backgroundColor = .white
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8.0
        containerView.spacing = 8
		containerView.axis = .horizontal
        containerView.clipsToBounds = true
		containerView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.isLayoutMarginsRelativeArrangement = true
        return containerView
    }()

    var imageTask: URLSessionDataTask?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        temtemImageView.image = nil
        imageTask?.cancel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .background
		selectionStyle = .none

        addSubview(containerView)
        containerView.addArrangedSubview(numLabel)
        containerView.addArrangedSubview(temtemImageView)
        containerView.addArrangedSubview(titleLabel)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			containerView.heightAnchor.constraint(equalToConstant: 70.0),
			containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            temtemImageView.widthAnchor.constraint(equalToConstant: 50.0),
            numLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 40.0)
        ])

    }

    func bind(viewModel: TemtemViewModel) {
        numLabel.text = viewModel.numberLabel
        titleLabel.text = viewModel.temtemName
        imageTask = temtemImageView.loadURL(url: viewModel.portraitWikiUrl)
    }
}
