//
//  APIService.swift
//  temtem
//
//  Created by Marlon Ansale on 11/14/22.
//

import Foundation
import Combine

public protocol HTTPClientTask {
	func cancel()
}

public typealias APIResultPublisher = AnyPublisher<(Data,HTTPURLResponse),Error>

public protocol HTTPClient {
    func dispatch(withURL url:URL) -> APIResultPublisher
}

