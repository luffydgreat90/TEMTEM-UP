//
//  TemtemCell.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import UIKit

public final class TemtemCell: UITableViewCell {
    public private(set) lazy var numberLabel: UILabel = {
        let numLabel = UILabel()
        numLabel.textColor = .black
        numLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        numLabel.translatesAutoresizingMaskIntoConstraints = false
        return numLabel
    }()
    
    public private(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .textColor
        titleLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    public private(set) lazy var temtemImageView: UIImageView = {
        let temtemImageView = UIImageView()
        temtemImageView.backgroundColor = .none
        temtemImageView.contentMode = .scaleAspectFit
        temtemImageView.clipsToBounds = true
        temtemImageView.layer.masksToBounds = true
        temtemImageView.translatesAutoresizingMaskIntoConstraints = false
        return temtemImageView
    }()

    public private(set) var containerView: UIStackView = {
        let containerView = UIStackView()
        containerView.backgroundColor = .cellBackground
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8.0
        containerView.spacing = 8
		containerView.axis = .horizontal
        containerView.clipsToBounds = true
		containerView.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.isLayoutMarginsRelativeArrangement = true
        return containerView
    }()
    
    public private(set) lazy var typeElementStackView: TypeElementStackView = {
        let typeElementStackView = TypeElementStackView()
        typeElementStackView.translatesAutoresizingMaskIntoConstraints = false
        return typeElementStackView
    }()

    weak var imageTask: URLSessionDataTask?

    private override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        temtemImageView.image = nil
        imageTask?.cancel()
        typeElementStackView.removeAllViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .background
		selectionStyle = .none

        addSubview(containerView)
        containerView.addArrangedSubview(numberLabel)
        containerView.addArrangedSubview(temtemImageView)
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(typeElementStackView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 16).withPriority(999),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).withPriority(999),
			containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            temtemImageView.widthAnchor.constraint(equalToConstant: 50.0),
            numberLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 40.0)
        ])

    }

    public func bind(viewModel: TemtemViewModel) {
        numberLabel.text = viewModel.numberLabel
        titleLabel.text = viewModel.temtemName
        imageTask = temtemImageView.loadURL(url: viewModel.portraitWikiUrl)
        typeElementStackView.setupTypes(temtemTypes: viewModel.types)
    }
}


