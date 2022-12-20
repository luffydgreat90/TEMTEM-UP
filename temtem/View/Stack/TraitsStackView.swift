//
//  TraitsStackView.swift
//  temtem
//
//  Created by Marlon Ansale on 12/20/22.
//

import Foundation
import UIKit.UIStackView

public final class TraitsStackView: UIStackView{
    
    public init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.spacing = 8
    }
    
    public func setupTraits(traits:[String]){
        traits.forEach { trait in
            let label = UILabel()
            label.text = trait
            label.font = .systemFont(ofSize: 16, weight: .bold)
            self.addArrangedSubview(label)
        }
    }
    
}
