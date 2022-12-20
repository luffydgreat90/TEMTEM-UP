//
//  TypeElementStack.swift
//  temtem
//
//  Created by Marlon Ansale on 11/23/22.
//

import UIKit.UIStackView
import TemtemFeed

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
    
    
    func setupTypes(temtemTypes:[TemtemTypes]){
        temtemTypes.forEach { type in
            let typeImageView = ImageCacheView()
            typeImageView.loadImage(withURL: type.getImageURL())
            typeImageView.translatesAutoresizingMaskIntoConstraints = false
            typeImageView.widthAnchor.constraint(equalToConstant: 50).withPriority(999).isActive = true
            typeImageView.heightAnchor.constraint(equalToConstant: 50).withPriority(999).isActive = true
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
