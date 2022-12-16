//
//  BaseView.swift
//  temtem
//
//  Created by Marlon Ansale on 12/16/22.
//

import UIKit.UIView

public protocol BaseView: UIView {
    func setupView()
    func setupAddViews()
    func setupAutolayout()
}

extension BaseView {
    public func setupView() {
        setupAddViews()
        setupAutolayout()
    }
}

