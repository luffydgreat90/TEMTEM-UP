//
//  TemtemMapper.swift
//  temtem
//
//  Created by Marlon Ansale on 11/28/22.
//

import Foundation

public final class TemtemMapper {
    public enum Error: Swift.Error {
        case invalidData
    }
    
    private struct RemoteTemtem: Decodable {
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
    
    private struct Technique: Decodable {
        let name:String
        let source:String
        let levels:Int?
    }
    
    public static func map(_ data:Data) throws -> [TemtemViewModel] {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let temtems:[RemoteTemtem] = try? jsonDecoder.decode([RemoteTemtem].self, from: data) else{
            throw Error.invalidData
        }

        return temtems.map { temtem in
            let baseURL: String = .urlBase
            let largeIcon =  URL(string: "\(baseURL)\(temtem.icon)")
            let largeLumaIcon =  URL(string: "\(baseURL)\(temtem.lumaIcon)")
            let types =  temtem.types.map({ TemtemTypes(withType: $0)})
            
            return TemtemViewModel(number: temtem.number, temtemName: temtem.name, portraitWikiUrl: temtem.portraitWikiUrl, largeIcon: largeIcon, largeLumaIcon: largeLumaIcon, numberLabel: "#\(temtem.number)", gameDescription: temtem.gameDescription, types: types)
        }
    }
}
