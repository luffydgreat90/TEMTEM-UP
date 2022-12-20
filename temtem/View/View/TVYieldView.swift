//
//  TVYieldView.swift
//  temtem
//
//  Created by Marlon Ansale on 12/20/22.
//

import Foundation
import UIKit
import TemtemFeed

class TVYieldView: UIView {
    
    public private(set) var yieldLabel: UILabel = {
        let yieldLabel = UILabel()
        yieldLabel.text = "TV Yield"
        yieldLabel.font = .systemFont(ofSize: 17, weight: .black)
        return yieldLabel
    }()
    
    public private(set) var yieldStack: UIStackView = {
        let yieldStack = UIStackView()
        yieldStack.axis = .horizontal
        yieldStack.distribution = .fillEqually
        yieldStack.spacing = 8
        yieldStack.translatesAutoresizingMaskIntoConstraints = false
        return yieldStack
    }()
    
    public init(){
        super.init(frame: .zero)
        self.setupUI()
        self.setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.addSubview(yieldLabel)
        self.addSubview(yieldStack)
    }
    
    private func setupAutoLayout(){
        NSLayoutConstraint.activate([
            yieldLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            yieldLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            yieldStack.topAnchor.constraint(equalTo: yieldLabel.bottomAnchor, constant: 16),
            yieldStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            yieldStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    public func setupTraits(yields:[TVYields:Int]){
        yields.forEach { (yield,num) in
            let label = UILabel()
            label.font = .systemFont(ofSize: 16, weight: .bold)
            label.text = "\(yield.getYieldString())\n\(num)"
            yieldStack.addArrangedSubview(label)
        }
    }
    
}
