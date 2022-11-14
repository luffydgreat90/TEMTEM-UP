//
//  TemtemListViewController.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Combine
import UIKit

final class TemtemListViewController: UIViewController {
    private let viewModel: TemtemListViewModel!
    private let customView: TemtemListView!
    private lazy var dataSource = makeDataSource()
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
     
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = customView
        setupUI()
        setupBinding()
    }

    private func setupUI() {
        self.title = "Temtem UP!"
    
        self.customView.tableView.delegate = self
        self.customView.tableView.dataSource = dataSource
        
        self.customView.searchBar.searchTextField.textPublisher
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] search in

                self?.viewModel.searchTemtem(search: search)

            }.store(in: &cancelable)
    }
    
    private func setupBinding() {
        viewModel.$error
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] message in
                if let message = message {
                    self?.customView.displayError(message: message)
                }
            }).store(in: &cancelable)

        viewModel.$temtems
            .receive(on: RunLoop.main)
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "TemtemCell", for: indexPath) as! TemtemCell
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
		let viewController = TemtemDetailViewController(temtemDetailViewModel: temtemDetailViewModel)
		
		self.navigationController?.pushViewController(viewController, animated: true)
	}
}
