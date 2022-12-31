//
//  ImageDataService.swift
//  TemtemFeed
//
//  Created by Marlon Ansale on 12/16/22.
//

import Foundation
import Combine

public protocol ImageDataService {
	func loadImage(withURL url:URL) -> AnyPublisher<(Data,HTTPURLResponse),Error>
}
