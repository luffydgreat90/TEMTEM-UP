//
//  MockService.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/14/22.
//

import Foundation
import Combine
import TemtemFeed

public class MockTemtemService : TemtemService {
    public func fetchAllTemtems() -> TemtemLoader {
        return Deferred {
            Future { promise in
                promise(.success([mockTemtemViewModel1, mockTemtemViewModel2]))
            }
        }.eraseToAnyPublisher()
    }
}

public class MockTemtemServiceEmpty : TemtemService {
    public func fetchAllTemtems() -> TemtemLoader {
        return Deferred {
            Future { promise in
                promise(.success([]))
            }
        }.eraseToAnyPublisher()
    }
}

public class MockTemtemServiceError : TemtemService {
    public func fetchAllTemtems() -> TemtemLoader {
        return Deferred {
            Future { promise in
                promise(.failure(URLError.badServerResponse as! Error))
            }
        }.eraseToAnyPublisher()
    }
}
