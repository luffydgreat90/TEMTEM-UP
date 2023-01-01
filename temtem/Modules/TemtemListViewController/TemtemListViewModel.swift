//
//  TemtemListViewModel.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Combine
import Foundation
import TemtemFeed

public final class TemtemListViewModel {
    private let temtemService: TemtemService
    private var temtemsCached: [TemtemViewModel] = []
    private let selection: (TemtemViewModel) -> Void
    public let imageLoader: (URL) -> AnyPublisher<Data, Error>
    
    @Published
    public private(set) var temtems: [TemtemViewModel] = []
    
    @Published
    public private(set) var error:String?
    
    private var cancelable: AnyCancellable?
    
    public init(temtemService: TemtemService,
                imageLoader: @escaping (URL) -> AnyPublisher<Data, Error>,
                selection: @escaping (TemtemViewModel) -> Void) {
        self.temtemService = temtemService
        self.selection = selection
        self.imageLoader = imageLoader
    }
    
    public lazy var title: String = {
        let bundle = Bundle(for: TemtemListViewController.self)
        let localizedKey:String = "TEMTEM_LIST_TITLE"
        return  bundle.localizedString(forKey: localizedKey, value: nil, table: "TemtemList")
    }()
    
    public lazy var search: String = {
        let bundle = Bundle(for: TemtemListViewController.self)
        let localizedKey:String = "TEMTEM_SEARCH"
        return  bundle.localizedString(forKey: localizedKey, value: nil, table: "TemtemList")
    }()
    
    public func fetchTemtems() {
        temtemsCached = []
        
        cancelable?.cancel()
        cancelable = temtemService
            .fetchAllTemtems().sink(receiveCompletion: { [weak self] result in
                switch  result {
                case .finished:break
                case .failure(let error):
						self?.error = error.localizedDescription
						self?.temtems =  []
                    break
                }

            }, receiveValue: { [weak self] result in
                self?.temtemsCached = result
                self?.temtems = result
            })
    }

    public func searchTemtem(search: String) {
        guard !search.isEmpty else{
            temtems = temtemsCached
            return
        }

		let temtemSet = Set(temtemsCached)
		let temtemsSearched = temtemSet.filter {  $0.temtemName.lowercased().contains(search.lowercased())}
		
		if temtemsSearched.isEmpty {
			temtems = []
			error = "'\(search)' not found!"
		}else{
            temtems = temtemsSearched.sorted(by: {
                $0.number < $1.number
            })
		}
       
    }
    
    public func selectedTemtem(onRow row:Int){
        guard let temtemViewModel = self.temtems[safe: row] else{
            return
        }
        
        self.selection(temtemViewModel)
    }
}
