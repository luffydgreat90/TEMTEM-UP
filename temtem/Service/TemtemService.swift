//
//  TemtemService.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Foundation
import Combine

protocol TemtemService {
	func fetchAllTemtem() -> AnyPublisher<[TemtemViewModel],Error>
	//func fetchAllElement() ->  AnyPublisher<[TemtemViewModel],Error>
}
