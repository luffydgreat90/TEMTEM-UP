//
//  TemtemDetailView.swift
//  temtem
//
//  Created by Marlon Ansale on 11/15/22.
//

import UIKit

public class TemtemDetailView: UIView {

    public private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 4.0
        imageView.addCornerRadius(.layerMinXMinYCorner, radius: 16)
        return imageView
    }()

    public private(set) lazy var nameLabel: UILabel = {
        let numberLabel = UILabel()
        numberLabel.textColor = .black
        numberLabel.font = .systemFont(ofSize: 24, weight: .bold)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberLabel
    }()

    public private(set) lazy var typesStackView: TypeElementStackView = {
        let stackView = TypeElementStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    public private(set) lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public private(set) lazy var textDetails: UITextView = {
        let textDetails = UITextView(frame: .zero)
        textDetails.translatesAutoresizingMaskIntoConstraints = false
      
        textDetails.isScrollEnabled = false
        textDetails.isUserInteractionEnabled = false
        textDetails.backgroundColor = .clear
        textDetails.textColor = .textColor
        var attributes = [NSAttributedString.Key: Any]()
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12
        attributes[.paragraphStyle] = paragraphStyle
        attributes[.font] = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        
        textDetails.typingAttributes = attributes
        
        return textDetails
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TemtemDetailView: BaseView {
    
    public func setupAddViews() {
        addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        
    }
    
    public func setupAutolayout() {
        let customView = UIView()
        customView.addSubviews(views: [imageView, nameLabel, typesStackView, textDetails])
        scrollStackViewContainer.addArrangedSubview(customView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
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
            
            textDetails.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16.0),
            textDetails.leftAnchor.constraint(equalTo: customView.safeAreaLayoutGuide.leftAnchor, constant: 16.0),
            textDetails.rightAnchor.constraint(equalTo: customView.rightAnchor, constant: -16.0),
        ])
    }
}
