//
//  TypeElementStack.swift
//  temtem
//
//  Created by Marlon Ansale on 11/23/22.
//

import UIKit.UIStackView
import TemtemFeed

public final class TypeElementStackView: UIStackView{
    
    init(){
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
            let constraintWidth = typeImageView.widthAnchor.constraint(equalToConstant: 50)
            let constraintHeight = typeImageView.heightAnchor.constraint(equalToConstant: 50)
            constraintWidth.isActive = true
            constraintHeight.isActive = true

            constraintWidth.priority = UILayoutPriority(999)
            constraintHeight.priority = UILayoutPriority(999)

            typeImageView.clipsToBounds = true
            typeImageView.contentMode = .scaleAspectFit
            self.addArrangedSubview(typeImageView)
        }
    }
    
    func removeAllViews(){
        arrangedSubviews.forEach { subView in
            subView.removeFromSuperview()
        }
    }
}
