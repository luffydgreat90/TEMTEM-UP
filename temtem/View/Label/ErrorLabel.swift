//
//  ErrorLabel.swift
//  temtem
//
//  Created by Marlon Ansale on 11/14/22.
//

import UIKit.UILabel

public final class ErrorLabel : UILabel {
    
    init(){
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.textColor = .red
        self.textAlignment = .center
        self.numberOfLines = 0
        self.font = .systemFont(ofSize: 17.0, weight: .black)
    }
}
