//
//  LocationViewModel.swift
//  TemtemFeed
//
//  Created by Marlon Ansale on 12/24/22.
//

import Foundation

public struct LocationViewModel {
	let location:String
	let island:String
	let frequency:String
	let level:String
}

private struct FreetemViewModel: Decodable {
	let minLevel:Int
	let maxLevel:Int
	let minPansuns:Int
	let maxPansuns:Int
}
