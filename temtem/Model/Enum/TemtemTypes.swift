//
//  TemtemTypes.swift
//  temtem
//
//  Created by marlon von ansale on 02/11/2022.
//

import Foundation

enum TemtemTypes: String {
	case crystal = "Crystal"
	case earth = "Earth"
	case neutral = "Neutral"
	case fire = "Fire"
	case nature = "Nature"
	case electric = "Electric"
	case mental = "Mental"
	case wind = "Wind"
	case digital = "Digital"
	case melee = "Melee"
	case toxic = "Toxic"
	case water  = "Water"
	case unowned = ""
}

extension TemtemTypes {
	init(string:String) {
		self = TemtemTypes.init(rawValue: string) ?? .unowned
	}
	
	func getImageURL() -> URL? {
		return URL(string: "\(kMainURL)/images/icons/types/\(self.rawValue).png")
	}
}
