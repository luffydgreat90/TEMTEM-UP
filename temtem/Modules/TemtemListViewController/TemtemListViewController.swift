//
//  TemtemListViewController.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Combine
import UIKit
import TemtemFeed

public final class TemtemListViewController: BaseViewController<TemtemListView, TemtemListViewModel>{
    private lazy var dataSource: UITableViewDiffableDataSource<Int, TemtemViewModel> = makeDataSource()
	private lazy var cancelable = Set<AnyCancellable>()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        setupFetched()
    }

    private func setupUI() {
        self.title = self.viewModel.title
        self.navigationController?.navigationBar.prefersLargeTitles = true

        let searchController = UISearchController()
        searchController.searchBar.searchTextField.backgroundColor = .lightGray
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.searchTextField.placeholder = viewModel.search
        searchController.searchBar.searchTextField.textPublisher
            .debounce(for: 0.5, scheduler: queueInitiated)
            .removeDuplicates()
            .sink { [weak self] search in
                self?.viewModel.searchTemtem(search: search)
            }.store(in: &cancelable)

        self.navigationItem.searchController = searchController
        dataSource.defaultRowAnimation = .fade
        self.customView.tableView.delegate = self
        self.customView.tableView.dataSource = dataSource
        self.customView.tableView.prefetchDataSource = self
    }
    
    private func setupBinding() {
        viewModel.$error
            .dispatchOnMainQueue()
            .removeDuplicates()
            .sink(receiveValue: { [weak self] message in
                guard let self = self, let message = message else{
                    return
                }
               
                self.customView.displayError(message: message)
                self.customView.hideHud()
                
            }).store(in: &cancelable)

        viewModel.$temtems
            .dispatchOnMainQueue()
            .sink(receiveValue: { [weak self] temtems in
                guard let self = self else{
                    return
                }
                
                if !temtems.isEmpty {
                    self.customView.hideError()
                    self.customView.hideHud()
                }
                
                self.display(list: temtems)
            }).store(in: &cancelable)
    }
    
    private func setupFetched(){
        viewModel.fetchTemtems()
    }
    
    public func display(list:[TemtemViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, TemtemViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(list, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

private extension TemtemListViewController {
    func makeDataSource() -> UITableViewDiffableDataSource<Int, TemtemViewModel> {
        return UITableViewDiffableDataSource(
            tableView: self.customView.tableView,
            cellProvider: { [weak self]  tableView, indexPath, temtemViewModel in
                let cell: TemtemCell = tableView.dequeueReusableCell()
                cell.bind(viewModel: temtemViewModel, imageLoader: self?.viewModel.imageLoader)
                return cell
            }
        )
    }
}

extension TemtemListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectedTemtem(onRow: indexPath.row)
	}
}

extension TemtemListViewController: UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell: TemtemCell = tableView.dequeueReusableCell()
        cell.cancelRequest()
    }
    
    
}
