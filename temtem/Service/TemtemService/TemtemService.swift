//
//  TemtemService.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Foundation
import Combine

typealias TemtemLoader = AnyPublisher<[TemtemViewModel],Error>

protocol TemtemService {
	func fetchAllTemtem() -> TemtemLoader
}

