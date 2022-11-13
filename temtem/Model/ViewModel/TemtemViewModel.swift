//
//  TemtemViewModel.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Foundation

struct TemtemViewModel: Hashable {
	let number:Int
	let temtemName:String
	let portraitWikiUrl:URL
	let largeIcon:URL?
	let largeLumaIcon:URL?
	let numberLabel:String
	let gameDescription: String
	let types:[TemtemTypes]
	
	init(temtem:Temtem) {
		self.number = temtem.number
		self.temtemName = temtem.name
		self.portraitWikiUrl = temtem.portraitWikiUrl
		self.gameDescription = temtem.gameDescription
		
		self.largeIcon =  URL(string: "\(kMainURL)\(temtem.icon)")
		self.largeLumaIcon =  URL(string: "\(kMainURL)\(temtem.lumaIcon)")
		self.numberLabel = "#\(number)"
		self.types =  temtem.types.map({ TemtemTypes(string:  $0 )})
	}
	
}
