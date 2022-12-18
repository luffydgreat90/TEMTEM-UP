//
//  TemtemDetailView.swift
//  temtem
//
//  Created by Marlon Ansale on 11/15/22.
//

import UIKit

public class TemtemDetailView: UIView {

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
        nameLabel.backgroundColor = .red
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

    private lazy var scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillProportionally
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
        paragraphStyle.lineSpacing = 8
        attributes[.paragraphStyle] = paragraphStyle
        attributes[.font] = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        textDetails.typingAttributes = attributes
        
        return textDetails
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        contentView.addSubview(scrollStackViewContainer)
        
        scrollStackViewContainer.addArrangedSubview(nameLabel)
        //scrollStackViewContainer.addArrangedSubview(imageView)
        scrollStackViewContainer.addArrangedSubview(typesStackView)
        scrollStackViewContainer.addArrangedSubview(textDetails)
    }
    
    public func setupAutoLayout() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            scrollStackViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            nameLabel.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
}
