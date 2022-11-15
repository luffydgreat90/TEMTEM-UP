//
//  TemtemDetailView.swift
//  temtem
//
//  Created by MacPro on 11/15/22.
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

    private(set) lazy var numberLabel: UILabel = {
        let numberLabel = UILabel()
        numberLabel.textColor = .black
        numberLabel.font = .systemFont(ofSize: 24, weight: .bold)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberLabel
    }()

    private(set) lazy var typesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.contentMode = .scaleAspectFit
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
        customView.addSubview(imageView)
        customView.addSubview(numberLabel)
        customView.addSubview(typesStackView)
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

            numberLabel.topAnchor.constraint(equalTo: customView.layoutMarginsGuide.topAnchor, constant: 8),
            numberLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            numberLabel.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -8),
            numberLabel.heightAnchor.constraint(equalToConstant: 20),

            typesStackView.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 4),
            typesStackView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            typesStackView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            rightAnchor.constraint(greaterThanOrEqualTo: typesStackView.rightAnchor, constant: -8),
        ])
        
    }
    
    func setupTypes(temtemTypes:[TemtemTypes]){
        for type in temtemTypes {
            let typeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            typeImageView.loadURL(url: type.getImageURL())

            typeImageView.translatesAutoresizingMaskIntoConstraints = false
            let constraintWidth = typeImageView.widthAnchor.constraint(equalToConstant: 50)
            let constraintHeight = typeImageView.heightAnchor.constraint(equalToConstant: 50)
            constraintWidth.isActive = true
            constraintHeight.isActive = true

            constraintWidth.priority = UILayoutPriority(999)
            constraintHeight.priority = UILayoutPriority(999)

            typeImageView.clipsToBounds = true
            typeImageView.contentMode = .scaleAspectFit
            typeImageView.isHidden = true

            typeImageView.fadeIn(2)
            typesStackView.addArrangedSubview(typeImageView)
        }
    }
    
}
