//
//  TemtemListView.swift
//  temtem
//
//  Created by Marlon Ansale on 11/14/22.
//

import UIKit

final class TemtemListView : UIView {
    
    private(set) lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: CGRectZero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .background
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        return tableView
    }()

    private(set) lazy var errorLabel: ErrorLabel = {
        let errorLabel = ErrorLabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        return errorLabel
    }()
    
    private(set) lazy var filterButton: UIButton = {
        let filterButton = UIButton(frame: .zero)
        filterButton.setTitle("+", for: .normal)
        filterButton.layer.cornerRadius = 25.0
        filterButton.backgroundColor = .buttonColor
        filterButton.layer.masksToBounds = true
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        return filterButton
    }()
    
    init(){
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubviews(views: [tableView,errorLabel, filterButton])
        self.backgroundColor = .background
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            filterButton.heightAnchor.constraint(equalToConstant: 50.0),
            filterButton.widthAnchor.constraint(equalToConstant: 50.0),
            filterButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
            filterButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20.0)
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
    
    func showFilterButton(isHidden:Bool){
        self.filterButton.setIsHidden(isHidden, 1.0, animated: true)
    }
}
