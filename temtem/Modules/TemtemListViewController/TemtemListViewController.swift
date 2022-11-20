//
//  TemtemListViewController.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Combine
import UIKit

final class TemtemListViewController: UIViewController {
    private(set) var viewModel: TemtemListViewModel!
    private(set) var customView: TemtemListView!
    private lazy var dataSource: UITableViewDiffableDataSource<Int, TemtemViewModel> = makeDataSource()
	private var cancelable = Set<AnyCancellable>()

    init(customView: TemtemListView, viewModel: TemtemListViewModel) {
        self.viewModel = viewModel
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = customView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
    }

    private func setupUI() {
        self.title = "Temtem UP!"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController()
        
        searchController.searchBar.searchTextField.textPublisher
            .debounce(for: 0.5, scheduler: queueInitiated)
            .removeDuplicates()
            .sink { [weak self] search in

                self?.viewModel.searchTemtem(search: search)

            }.store(in: &cancelable)

        self.navigationItem.searchController = searchController
        self.customView.tableView.register(TemtemCell.self, forCellReuseIdentifier: String(describing: TemtemCell.self))
        self.customView.tableView.delegate = self
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
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let temtemViewModel = viewModel.temtems[indexPath.row]
		
		let temtemDetailViewModel = TemtemDetailViewModel(temtemViewModel: temtemViewModel)
        let viewController = TemtemDetailViewController(temtemDetailView: TemtemDetailView(), temtemDetailViewModel: temtemDetailViewModel)
		
		self.navigationController?.pushViewController(viewController, animated: true)
	}
}

