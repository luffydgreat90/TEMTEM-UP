//
//  TemtemCell.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import UIKit

final class TemtemCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        return titleLabel
    }()

    let temtemImageView: UIImageView = {
        let temtemImageView = UIImageView()
        temtemImageView.backgroundColor = .clear
        temtemImageView.contentMode = .scaleAspectFit
        temtemImageView.clipsToBounds = true
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
        backgroundColor = .none
		selectionStyle = .none

        addSubview(containerView)
        containerView.addArrangedSubview(temtemImageView)
        containerView.addArrangedSubview(titleLabel)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        temtemImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			
			containerView.heightAnchor.constraint(equalToConstant: 70.0),
			containerView.centerYAnchor.constraint(equalTo: centerYAnchor),

            temtemImageView.widthAnchor.constraint(equalToConstant: 50.0),
        ])

    }

    func bind(viewModel: TemtemViewModel) {
        titleLabel.text = viewModel.temtemName
        imageTask = temtemImageView.loadURL(url: viewModel.portraitWikiUrl)
    }
}
