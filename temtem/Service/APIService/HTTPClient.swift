//
//  APIService.swift
//  temtem
//
//  Created by Marlon Ansale on 11/14/22.
//

import Foundation
import Combine

public typealias APIResultPublisher = AnyPublisher<(Data,HTTPURLResponse),Error>

public protocol HTTPClient {
    func dispatch(withAppendURL:String) -> APIResultPublisher
}

