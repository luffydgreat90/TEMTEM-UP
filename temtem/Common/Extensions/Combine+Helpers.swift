//
//  Combine+Helpers.swift
//  temtem
//
//  Created by Marlon Ansale on 12/31/22.
//

import Foundation
import Combine
import TemtemFeed

extension Publisher {
    func fallback(to fallbackPublisher: @escaping () -> AnyPublisher<Output, Failure>) -> AnyPublisher<Output, Failure> {
        self.catch { _ in fallbackPublisher() }.eraseToAnyPublisher()
    }
}

extension Publisher where Output == Data {
    func caching(to cache: ImageCacheService, using url: URL) -> AnyPublisher<Output, Failure> {
        handleEvents(receiveOutput: { data in
            try? cache.insert(data, for: url)
        }).eraseToAnyPublisher()
    }
}
