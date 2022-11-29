//
//  TemtemService.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Foundation
import Combine

public typealias TemtemLoader = AnyPublisher<[TemtemViewModel],Error>

public protocol TemtemService {
    func fetchAllTemtems() -> TemtemLoader
}

