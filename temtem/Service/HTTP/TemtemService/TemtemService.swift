//
//  TemtemService.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Foundation
import Combine

public protocol TemtemService {
    typealias TemtemLoader = AnyPublisher<[TemtemViewModel],Error>
    func fetchAllTemtems() -> TemtemLoader
}

