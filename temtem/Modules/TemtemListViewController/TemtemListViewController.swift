//
//  TemtemListViewController.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Combine
import UIKit

final class TemtemListViewController: BaseViewController<TemtemListView, TemtemListViewModel>{
    private lazy var dataSource: UITableViewDiffableDataSource<Int, TemtemViewModel> = makeDataSource()
	private lazy var cancelable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }

    private func setupUI() {
        self.title = "Temtem UP!"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController()
        searchController.searchBar.searchTextField.backgroundColor = .lightGray
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.searchTextField.textPublisher
            .debounce(for: 0.5, scheduler: queueInitiated)
            .removeDuplicates()
            .sink { [weak self] search in
                self?.viewModel.searchTemtem(search: search)
            }.store(in: &cancelable)

        self.navigationItem.searchController = searchController
        self.customView.tableView.delegate = self
        dataSource.defaultRowAnimation = .fade
        self.customView.tableView.dataSource = dataSource
    
    }
    
    private func setupBinding() {
        viewModel.$error
            .receive(on: queueInitiated)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] message in
                if let message = message {
                    self?.customView.displayError(message: message)
                }
            }).store(in: &cancelable)

        viewModel.$temtems
            .receive(on: queueInteractive)
            .sink(receiveValue: { [weak self] results in
                
                if !results.isEmpty {
                    self?.customView.hideError()
                }
                
                var snapshot = NSDiffableDataSourceSnapshot<Int, TemtemViewModel>()
                snapshot.appendSections([0])
                snapshot.appendItems(results, toSection: 0)
                self?.dataSource.apply(snapshot, animatingDifferences: true)
                
            }).store(in: &cancelable)

        viewModel.fetchTemtems()
    }
}

private extension TemtemListViewController {
    func makeDataSource() -> UITableViewDiffableDataSource<Int, TemtemViewModel> {
        return UITableViewDiffableDataSource(
            tableView: self.customView.tableView,
            cellProvider: { tableView, indexPath, temtemViewModel in
                let cell: TemtemCell = tableView.dequeueReusableCell()
                cell.bind(viewModel: temtemViewModel)
                return cell
            }
        )
    }
}

extension TemtemListViewController : UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.customView.showFilterButton(isHidden: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.customView.showFilterButton(isHidden: false)
    }
    
    
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let temtemViewModel = viewModel.temtems[indexPath.row]
		
        let viewController: TemtemDetailViewController = TemtemDetailFactory.createTemtemDetailViewController(temtemViewModel: temtemViewModel)
        
		self.navigationController?.pushViewController(viewController, animated: true)
	}
}

