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
    
    private(set) var urlSessions:[URLSessionDataTask?]? = []
    
    func setupTypes(temtemTypes:[TemtemTypes]){
        
        self.urlSessions = []
        
        for type in temtemTypes {
            let typeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            let urlSession = typeImageView.loadURL(url: type.getImageURL())
            self.urlSessions?.append(urlSession)
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
        
        self.urlSessions?.forEach { urlSession in
            urlSession?.cancel()
        }
    }
}
