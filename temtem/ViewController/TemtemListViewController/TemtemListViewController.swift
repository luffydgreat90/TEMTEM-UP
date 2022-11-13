//
//  TemtemListViewController.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Combine
import UIKit

final class TemtemListViewController: UIViewController {
    let viewModel: TemtemListViewModel!

	private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: CGRectZero, style: .plain)
        tableView.register(TemtemCell.self, forCellReuseIdentifier: "TemtemCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .interactive
		tableView.rowHeight = 80.0
        return tableView
    }()

	private lazy var searchBar = UISearchBar()

	private lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
		errorLabel.textColor = .black
		errorLabel.translatesAutoresizingMaskIntoConstraints = false
        return errorLabel
    }()

    private lazy var dataSource = makeDataSource()

	private var cancelable = Set<AnyCancellable>()

    init(viewModel: TemtemListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

		self.title = "Temtem UP!"
        view.addSubview(tableView)
        view.addSubview(searchBar)

        searchBar.backgroundImage = UIImage()

        searchBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

		tableView.delegate = self
        tableView.dataSource = dataSource
        
        searchBar.searchTextField.textPublisher
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] search in

                self?.viewModel.searchTemtem(search: search)

            }.store(in: &cancelable)

        viewModel.$error
            .receive(on: RunLoop.main)
            .removeDuplicates()
			.sink(receiveValue: { [weak self] message in
				if let message = message {
					self?.displayError(message: message)
				}
			}).store(in: &cancelable)

        viewModel.$temtems
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] results in
				debugPrint("message_results \(results)")
				
				if !results.isEmpty {
					self?.errorLabel.removeFromSuperview()

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
    func displayError(message: String) {
        view.addSubview(errorLabel)
        NSLayoutConstraint.activate([
			errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        errorLabel.text = message
    }

    func makeDataSource() -> UITableViewDiffableDataSource<Int, TemtemViewModel> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
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
