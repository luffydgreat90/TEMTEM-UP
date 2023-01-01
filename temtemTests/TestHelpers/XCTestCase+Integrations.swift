//
//  XCTestCase+Integrations.swift
//  temtemTests
//
//  Created by Marlon Ansale on 1/1/23.
//

import XCTest
import Combine

extension XCTestCase {
    func loadImageDataPublisher(from url: URL) -> AnyPublisher<Data, Error> {
        let publisher = PassthroughSubject<Data, Error>()
        return publisher.eraseToAnyPublisher()
    }
}
