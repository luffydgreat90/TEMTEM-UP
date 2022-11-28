//
//  MockService.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/14/22.
//

import Foundation
import Combine
@testable import temtem

public class MockTemtemService : TemtemService {
    public func fetchAllTemtems() -> TemtemLoader {
       return Future() { promise in
           
           let temtem1 = Temtem(number: 1, name: "Anahir", portraitWikiUrl: URL(string: "test")!, gameDescription: "test", traits: [], types: [], techniques: [], icon: "star", lumaIcon: "star")
           let temtemVM1 = TemtemViewModel(temtem: temtem1)
           
           let temtem2 = Temtem(number: 2, name: "Golzy", portraitWikiUrl: URL(string: "test")!, gameDescription: "test", traits: [], types: [], techniques: [], icon: "star", lumaIcon: "star")
           let temtemVM2 = TemtemViewModel(temtem: temtem2)
           
           promise(.success([temtemVM1, temtemVM2]))
        }.eraseToAnyPublisher()
    }
}

public class MockTemtemServiceEmpty : TemtemService {
    public func fetchAllTemtems() -> TemtemLoader {
        return Future() { promise in
            promise(.success([]))
        }.eraseToAnyPublisher()
    }
}
