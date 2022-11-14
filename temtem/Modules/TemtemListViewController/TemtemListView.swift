//
//  TemtemListView.swift
//  temtem
//
//  Created by MacPro on 11/14/22.
//

import UIKit

class TemtemListView : UIView {
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: CGRectZero, style: .plain)
        tableView.register(TemtemCell.self, forCellReuseIdentifier: "TemtemCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = .background
        tableView.rowHeight = 80.0
        return tableView
    }()

    lazy var searchBar = UISearchBar()

    private(set) lazy var errorLabel: ErrorLabel = {
        let errorLabel = ErrorLabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        return errorLabel
    }()
    
    init(){
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(tableView)
        self.addSubview(searchBar)
        self.addSubview(errorLabel)

        self.backgroundColor = .background
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
       
    }
    
    func displayError(message: String) {
        errorLabel.text = message
        errorLabel.setIsHidden(false, animated: true)
    }
    
    func hideError(){
        errorLabel.text = ""
        errorLabel.setIsHidden(true, animated: true)
    }
}
