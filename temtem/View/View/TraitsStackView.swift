//
//  TraitsStackView.swift
//  temtem
//
//  Created by Marlon Ansale on 12/20/22.
//

import Foundation
import UIKit.UIStackView

public final class TraitsView: UIView{
    
    private let locale: Locale
    
    public private(set) var traitsLabel: UILabel = {
        let traitsLabel = UILabel()
        traitsLabel.font = .systemFont(ofSize: 16, weight: .bold)
        traitsLabel.text = "Temtem Traits"
        traitsLabel.translatesAutoresizingMaskIntoConstraints = false
        return traitsLabel
    }()
    
    public private(set) var traitsStack: UIStackView = {
        let traitsStack = UIStackView()
        traitsStack.axis = .horizontal
        traitsStack.distribution = .fillEqually
        traitsStack.spacing = 8
        traitsStack.translatesAutoresizingMaskIntoConstraints = false
        return traitsStack
    }()
    
    public init(locale:Locale = .current){
        self.locale = locale
        super.init(frame: .zero)
        setupUI()
        setupAutoLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.addSubview(traitsLabel)
        self.addSubview(traitsStack)
    }
    
    private func setupAutoLayout(){
        NSLayoutConstraint.activate([
            traitsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            traitsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            traitsStack.topAnchor.constraint(equalTo: traitsLabel.bottomAnchor, constant: 16),
            traitsStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            traitsStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    public func setupTraits(traits:[String]){
        traits.forEach { trait in
            let label = UILabel()
            label.text = trait
            label.font = .systemFont(ofSize: 16, weight: .bold)
            traitsStack.addArrangedSubview(label)
        }
    }
    
}
