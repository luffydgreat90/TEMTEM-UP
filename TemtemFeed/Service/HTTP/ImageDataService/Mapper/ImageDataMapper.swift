//
//  ImageDataMapper.swift
//  TemtemFeed
//
//  Created by Marlon Ansale on 12/31/22.
//

import Foundation

public enum ImageDataMapper {
	public enum Error: Swift.Error {
		case invalidData
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Data {
		guard response.statusCode == HTTPURLResponse.IS_OK, !data.isEmpty else {
			throw Error.invalidData
		}
		
		return data
	}
}
