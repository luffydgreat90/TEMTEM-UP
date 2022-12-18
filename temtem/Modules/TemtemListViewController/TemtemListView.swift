//
//  TemtemListView.swift
//  temtem
//
//  Created by Marlon Ansale on 11/14/22.
//

import UIKit

public final class TemtemListView : UIView {
    
    public private(set) lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: CGRectZero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        tableView.register(TemtemCell.self)
        return tableView
    }()

    public private(set) lazy var errorLabel: ErrorLabel = {
        let errorLabel = ErrorLabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        return errorLabel
    }()

    public private(set) lazy var progressHud: UIActivityIndicatorView = {
        let progressHud =  UIActivityIndicatorView()
        progressHud.style = .large
        progressHud.startAnimating()
        progressHud.translatesAutoresizingMaskIntoConstraints = false
        return progressHud
    }()
    
    init(){
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func displayError(message: String) {
        errorLabel.text = message
        errorLabel.setIsHidden(false, animated: true)
    }
    
    public func hideError(){
        errorLabel.text = ""
        errorLabel.setIsHidden(true, animated: true)
    }
    
    public func hideHud(){
        progressHud.isHidden = true
    }
    
}

extension TemtemListView: BaseView {
    public func setupAddViews() {
        self.addSubviews(views: [tableView,errorLabel, progressHud])
        self.backgroundColor = .background
    }
    
    public func setupAutolayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressHud.topAnchor.constraint(equalTo: self.topAnchor),
            progressHud.leftAnchor.constraint(equalTo: self.leftAnchor),
            progressHud.rightAnchor.constraint(equalTo: self.rightAnchor),
            progressHud.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
}
