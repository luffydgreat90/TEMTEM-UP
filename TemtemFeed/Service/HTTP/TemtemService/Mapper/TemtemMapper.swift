//
//  TemtemMapper.swift
//  temtem
//
//  Created by Marlon Ansale on 11/28/22.
//

import Foundation

public enum TemtemMapper {
	private struct RemoteTemtem: Decodable {
		let number:Int
		let name:String
		let portraitWikiUrl:URL
		let gameDescription:String
		let traits:[String]
		let types:[String]
		let techniques: [RemoteTechnique]
		let icon:String
		let lumaIcon:String
		let wikiUrl:String?
		let tvYields:[String:Int]
		let locations:[RemoteLocations]
	}
	
	private struct RemoteTechnique: Decodable {
		let name:String
		let source:String
		let levels:Int?
	}

	private struct RemoteLocations: Decodable {
		let location:String
		let island:String
		let frequency:String
		let level:String
		let freetem:RemoteFreetem
	}
	
	private struct RemoteFreetem: Decodable {
		let minLevel:Int
		let maxLevel:Int
		let minPansuns:Int
		let maxPansuns:Int
	}

    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, response: HTTPURLResponse) throws -> [TemtemViewModel] {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
	
        guard let temtems:[RemoteTemtem] = try? jsonDecoder.decode([RemoteTemtem].self, from: data), response.statusCode == HTTPURLResponse.IS_OK else{
            throw Error.invalidData
        }
        
		return toTemtemViewModel(temtems:temtems)
    }
	
	private static func toTemtemViewModel(temtems:[RemoteTemtem]) -> [TemtemViewModel] {
		temtems.map { temtem in
			let baseURL: String = .urlBase
			let largeIcon =  URL(string: "\(baseURL)\(temtem.icon)")
			let largeLumaIcon =  URL(string: "\(baseURL)\(temtem.lumaIcon)")
			let types =  temtem.types.map({ TemtemTypes(withType: $0)})
			var tvYields: [TVYields:Int] = [:]
			
			temtem.tvYields.forEach { (yield,num) in
				let tvYield = TVYields(withYield: yield)
				if num > 0, tvYield != .unowned {
					tvYields[tvYield] = num
				}
			}
			
			return TemtemViewModel(number: temtem.number, temtemName: temtem.name, portraitWikiUrl: temtem.portraitWikiUrl, largeIcon: largeIcon, largeLumaIcon: largeLumaIcon, numberLabel: "#\(temtem.number)", gameDescription: temtem.gameDescription, types: types, traits: temtem.traits, wikiUrl: temtem.wikiUrl, tvYields: tvYields)
		}
	}
}

