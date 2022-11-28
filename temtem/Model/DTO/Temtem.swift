//
//  Temtem.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Foundation

public struct Temtem: Decodable {
	let number:Int
	let name:String
	let portraitWikiUrl:URL
	let gameDescription:String
	let traits:[String]
	let types:[String]
	let techniques: [Technique]
	let icon:String
	let lumaIcon:String
}


