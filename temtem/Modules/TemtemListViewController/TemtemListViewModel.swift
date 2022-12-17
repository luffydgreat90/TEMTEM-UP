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
    
    @Published
    public private(set) var temtems: [TemtemViewModel] = []
    
    @Published
    public private(set) var error:String?
    
    private var cancelable: AnyCancellable?
    
    public init(temtemService: TemtemService) {
        self.temtemService = temtemService
    }
    
    public lazy var title: String = {
        let bundle = Bundle(for: TemtemListViewController.self)
        let localizedKey:String = "TEMTEM_LIST_TITLE"
        return  bundle.localizedString(forKey: localizedKey, value: nil, table: "TemtemList")
    }()
    
    public func fetchTemtems() {
        temtemsCached = []
        temtems = []
        
        cancelable?.cancel()
        cancelable = temtemService
            .fetchAllTemtems().sink(receiveCompletion: { [weak self] result in
                switch  result {
                case .finished:
                    break
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
        if search.isEmpty {
            temtems = temtemsCached
            return
        }

		let temtemSet = Set(temtemsCached)
		let temtemsSearched = temtemSet.filter {  $0.temtemName.lowercased().contains(search.lowercased())}
		
		if temtemsSearched.isEmpty {
			temtems = []
			error = "'\(search)' not found!"
		}else{
			temtems = Array(temtemsSearched)
		}
       
    }
}
