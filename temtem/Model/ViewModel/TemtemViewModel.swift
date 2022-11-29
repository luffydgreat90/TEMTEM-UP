//
//  TemtemViewModel.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Foundation

public struct TemtemViewModel: Hashable {
    public let number:Int
    public let temtemName:String
    public let portraitWikiUrl:URL
    public let largeIcon:URL?
    public let largeLumaIcon:URL?
    public let numberLabel:String
    public let gameDescription: String
    public let types:[TemtemTypes]
	
	public init(number:Int, temtemName:String, portraitWikiUrl:URL, largeIcon:URL?, largeLumaIcon:URL?, numberLabel:String, gameDescription: String, types:[TemtemTypes]) {
		self.number = number
		self.temtemName = temtemName
		self.portraitWikiUrl = portraitWikiUrl
		self.gameDescription = gameDescription
        self.largeIcon =  largeIcon
        self.largeLumaIcon =  largeLumaIcon
		self.numberLabel = numberLabel
		self.types =  types
	}
	
}
