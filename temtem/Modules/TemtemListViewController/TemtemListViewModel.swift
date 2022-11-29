//
//  TemtemListViewModel.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Combine
import Foundation

final class TemtemListViewModel {
    let temtemService: TemtemService

    private var temtemsCached: [TemtemViewModel] = []

    @Published
	private(set) var temtems: [TemtemViewModel] = []
	
	@Published
	private(set) var error:String?

    var cancelable: AnyCancellable?

    init(temtemService: TemtemService) {
        self.temtemService = temtemService
    }

    func fetchTemtems() {
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

    func searchTemtem(search: String) {
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
