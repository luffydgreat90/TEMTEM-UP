//
//  TemtemDetailView.swift
//  temtem
//
//  Created by Marlon Ansale on 11/15/22.
//

import UIKit

public class TemtemDetailView: UIView {

    public private(set) lazy var containerImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public private(set) lazy var imageView: ImageCacheView = {
        let imageView = ImageCacheView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 4.0
        imageView.addCornerRadius(radius: 16)
        return imageView
    }()
    
    public private(set) lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .buttonColor
        nameLabel.addCornerRadius(radius: 8)
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
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

    public private(set) lazy var textDetails: UITextView = {
        let textDetails = UITextView(frame: .zero)
        textDetails.translatesAutoresizingMaskIntoConstraints = false
        textDetails.isScrollEnabled = false
        textDetails.isUserInteractionEnabled = false
        textDetails.backgroundColor = .clear
        textDetails.textColor = .textColor
        var attributes = [NSAttributedString.Key: Any]()
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        attributes[.paragraphStyle] = paragraphStyle
        attributes[.font] = UIFont.systemFont(ofSize: 16.0, weight: .light)
        textDetails.typingAttributes = attributes
        
        return textDetails
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    public private(set) lazy var traitsView: TraitsView = {
        let traitsView = TraitsView()
        traitsView.translatesAutoresizingMaskIntoConstraints = false
        return traitsView
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
        scrollView.addSubview(contentView)
        contentView.addSubview(containerImageView)
        
        containerImageView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(typesStackView)
        contentView.addSubview(textDetails)
        contentView.addSubview(traitsView)
    }
    
    public func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            containerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerImageView.heightAnchor.constraint(equalToConstant: 150),
            containerImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
    
            imageView.centerXAnchor.constraint(equalTo: containerImageView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerImageView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 130),
            imageView.widthAnchor.constraint(equalToConstant: 130),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            typesStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            typesStackView.widthAnchor.constraint(equalToConstant: 100),
            typesStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            textDetails.topAnchor.constraint(equalTo: typesStackView.bottomAnchor, constant: 16),
            textDetails.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textDetails.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        
            traitsView.topAnchor.constraint(equalTo: textDetails.bottomAnchor, constant: 16),
            traitsView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            traitsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
}
