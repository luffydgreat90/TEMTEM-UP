//
//  TemtemServiceImplementation.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Combine
import Foundation

class TemtemServiceImplementation: TemtemService {
    let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func fetchAllTemtem() -> AnyPublisher<[TemtemViewModel], Error> {
       
        let baseURL:String = .urlBase
        let url = URL(string: "\(baseURL)/api/temtems")!

            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return self.apiService.loadModels(url: url, jsonDecoder: jsonDecoder)
                        .tryMap({ temtems in
                            temtems.map{ TemtemViewModel(temtem: $0) }
                        })
                        .eraseToAnyPublisher()
		
    }
}
