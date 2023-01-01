//
//  TypeElementStack.swift
//  temtem
//
//  Created by Marlon Ansale on 11/23/22.
//

import UIKit.UIStackView
import TemtemFeed
import Combine

public final class TypeElementStackView: UIStackView{
    
    public init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.axis = .horizontal
        self.distribution = .fillProportionally
        self.contentMode = .scaleAspectFit
    }

    func setupTypes(temtemTypes:[TemtemTypes], imageLoader:((URL) -> AnyPublisher<Data, Error>)?){
        temtemTypes.forEach { type in
            let typeImageView = ImageCacheView()
            typeImageView.loadImage(withURL: type.getImageURL(), imageLoader:imageLoader)
            typeImageView.translatesAutoresizingMaskIntoConstraints = false
            typeImageView.widthAnchor.constraint(equalToConstant: 40).withPriority(999).isActive = true
            typeImageView.heightAnchor.constraint(equalToConstant: 40).withPriority(999).isActive = true
            self.addArrangedSubview(typeImageView)
        }
    }
    
    func removeAllViews(){
        arrangedSubviews.forEach { subView in
            if let imageView = subView as? ImageCacheView {
                imageView.cancelImageRequest()
            }
            subView.removeFromSuperview()
        }
    }
}
