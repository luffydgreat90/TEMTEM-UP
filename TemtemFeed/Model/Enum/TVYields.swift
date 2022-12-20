//
//  TVYields.swift
//  TemtemFeed
//
//  Created by Marlon Ansale on 12/20/22.
//

import Foundation

public enum TVYields: String {
	case hp
	case sta
	case spd
	case atk
	case def
	case spatk
	case spdef
	case unowned
}

public extension TVYields {
	init(withYield string:String) {
		self = TVYields.init(rawValue: string) ?? .unowned
	}
	
	func getYieldString() -> String {
		self.rawValue.uppercased()
	}
}
