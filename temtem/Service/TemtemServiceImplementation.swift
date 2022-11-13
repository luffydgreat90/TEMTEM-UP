//
//  TemtemServiceImplementation.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Combine
import Foundation

class TemtemServiceImplementation: TemtemService {
    func fetchAllTemtem() -> AnyPublisher<[TemtemViewModel], Error> {
       
            let url = URL(string: "\(kMainURL)/api/temtems")!

            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
			return URLSession.shared.dataTaskPublisher(for: url)
				.tryMap { result in
					guard let httpResponse = result.response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
						throw URLError(.badServerResponse)
					}
					return result.data
				}
                .decode(type: [Temtem].self, decoder: jsonDecoder)
                .tryMap({ temtems in
                    temtems.map{ TemtemViewModel(temtem: $0) }
                })
                .eraseToAnyPublisher()
		
    }
}
