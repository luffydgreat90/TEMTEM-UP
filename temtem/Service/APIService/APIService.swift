//
//  APIService.swift
//  temtem
//
//  Created by Marlon Ansale on 11/14/22.
//

import Foundation
import Combine

public typealias APIResultPublisher = AnyPublisher<(Data,Int),Error>

public protocol APIService {
    func dispatch(withAppendURL:String) -> APIResultPublisher
}

