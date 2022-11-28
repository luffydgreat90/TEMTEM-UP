//
//  APIService.swift
//  temtem
//
//  Created by Marlon Ansale on 11/14/22.
//

import Foundation
import Combine

let OK_200: Int = 200

final public class APIService {
    
    private lazy var baseURL:URL = {
        URL(string: String.urlBase)!
    }()

    
    func getData(withBase base:String = String.urlBase, appendURL:String, jsonDecoder:JSONDecoder = JSONDecoder())  -> AnyPublisher<Data,Error>{
      
        let request = URLRequest(
            url: baseURL
                .appendingPathComponent(appendURL)
        )
       
        return loadURL(withURLRequest: request)
            .subscribe(on: queueBackgroundInitiated)
            .eraseToAnyPublisher()
    }
    
    private func loadURL(withURLRequest request:URLRequest) -> AnyPublisher<Data,Error>{
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == OK_200 else{
                    throw URLError(.badServerResponse)
                }

                return result.data
            }.eraseToAnyPublisher()
    }
}
