//
//  APIService.swift
//  temtem
//
//  Created by Marlon Ansale on 11/14/22.
//

import Foundation
import Combine

final public class APIService {
    func loadModels<MODEL:Decodable>(withURL url:URL, jsonDecoder:JSONDecoder = JSONDecoder()) -> AnyPublisher<[MODEL],Error>{
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else{
                    throw URLError(.badServerResponse)
                }

                return result.data
            }
            .decode(type: [MODEL].self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
