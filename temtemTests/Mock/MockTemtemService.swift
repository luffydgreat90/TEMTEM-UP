//
//  MockService.swift
//  temtemTests
//
//  Created by MacPro on 11/14/22.
//

import Foundation
import Combine
@testable import temtem
class MockTemtemService : TemtemService {
    func fetchAllTemtem() -> AnyPublisher<[TemtemViewModel], Error> {
       return Future() { promise in
           
           let temtem1 = Temtem(number: 1, name: "Anahir", portraitWikiUrl: URL(string: "test")!, gameDescription: "test", traits: [], types: [], techniques: [], icon: "star", lumaIcon: "star")
           let temtemVM1 = TemtemViewModel(temtem: temtem1)
           
           let temtem2 = Temtem(number: 2, name: "Golzy", portraitWikiUrl: URL(string: "test")!, gameDescription: "test", traits: [], types: [], techniques: [], icon: "star", lumaIcon: "star")
           let temtemVM2 = TemtemViewModel(temtem: temtem2)
           
           promise(.success([temtemVM1, temtemVM2]))
        }.eraseToAnyPublisher()
    }
}
