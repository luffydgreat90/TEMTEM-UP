//
//  TemtemDetailView.swift
//  temtem
//
//  Created by Marlon Ansale on 11/15/22.
//

import UIKit

class TemtemDetailView: UIView {
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 4.0
        imageView.addCornerRadius(.layerMinXMinYCorner, radius: 16)
        return imageView
    }()

    private(set) lazy var nameLabel: UILabel = {
        let numberLabel = UILabel()
        numberLabel.textColor = .black
        numberLabel.font = .systemFont(ofSize: 24, weight: .bold)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberLabel
    }()

    private(set) lazy var typesStackView: TypeElementStackView = {
        let stackView = TypeElementStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private(set) var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        let customView = UIView()
        customView.addSubviews(views: [imageView, nameLabel, typesStackView])
        scrollStackViewContainer.addArrangedSubview(customView)

        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: customView.layoutMarginsGuide.topAnchor, constant: 8),
            imageView.leftAnchor.constraint(equalTo: customView.layoutMarginsGuide.leftAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),

            nameLabel.topAnchor.constraint(equalTo: customView.layoutMarginsGuide.topAnchor, constant: 8),
            nameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -8),
           
            typesStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            typesStackView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            typesStackView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            rightAnchor.constraint(greaterThanOrEqualTo: typesStackView.rightAnchor, constant: -8),
        ])
        
    }
    

    
}
