//
//  ErrorLabel.swift
//  temtem
//
//  Created by MacPro on 11/14/22.
//

import UIKit.UILabel

class ErrorLabel : UILabel {
    
    init(){
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.textColor = .red
        self.font = .systemFont(ofSize: 17.0, weight: .black)
    }
}
