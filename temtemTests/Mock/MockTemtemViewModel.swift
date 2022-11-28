//
//  MockTemtemViewModel.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/28/22.
//

import Foundation
@testable import temtem

fileprivate let temtem1 = Temtem(number: 1, name: "Anahir", portraitWikiUrl: URL(string: "test")!, gameDescription: "test", traits: [], types: [], techniques: [], icon: "star", lumaIcon: "star")

let mockTemtemViewModel = TemtemViewModel(temtem: temtem1)
