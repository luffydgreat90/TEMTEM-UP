//
//  MockTemtemViewModel.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/28/22.
//

import Foundation
import temtem
import TemtemFeed

fileprivate func makeURL(_ str: String = "https://any-given-url.com") -> URL {
    URL(string: str)!
}

let mockTemtemViewModel1 = TemtemViewModel(number: 1, temtemName: "Anahir", portraitWikiUrl: makeURL(), largeIcon: makeURL(), largeLumaIcon: makeURL(), numberLabel: "#1", gameDescription: "test description", types: [TemtemTypes.crystal], traits: ["Trauma","Flawed Crystal"], wikiUrl: "", tvYields: [.hp:2],techniques:[])

let mockTemtemViewModel2 = TemtemViewModel(number: 2, temtemName: "Golzy", portraitWikiUrl: makeURL(), largeIcon: makeURL(), largeLumaIcon: makeURL(), numberLabel: "#2", gameDescription: "test description", types: [TemtemTypes.electric, TemtemTypes.melee], traits: ["Defuser","Voltaic Charge"], wikiUrl: "", tvYields: [.atk:3], techniques:[])
