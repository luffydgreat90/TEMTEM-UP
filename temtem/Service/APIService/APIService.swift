//
//  APIService.swift
//  temtem
//
//  Created by Marlon Ansale on 11/14/22.
//

import Foundation
import Combine

let OK_200: Int = 200

typealias APIResultPublisher = AnyPublisher<(Data,Int),Error>

protocol APIService {
    func dispatch(withAppendURL:String) -> APIResultPublisher
}

extension APIService {
    func loadURL(withURLRequest request:URLRequest) -> APIResultPublisher {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == HTTPURLResponse.IS_OK else{
                    throw URLError(.badServerResponse)
                }
                return (result.data, response.statusCode)
            }.eraseToAnyPublisher()
    }
}
