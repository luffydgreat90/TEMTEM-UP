//
//  TechniqueDetail.swift
//  temtem
//
//  Created by marlon von ansale on 02/11/2022.
//

import Foundation

struct TechniqueDetail {
	let type:String
	let name:String
	let hold:Int
	let classType:String
	
	enum CodingKeys: String, CodingKey {
		case classType = "class"
	}
}
