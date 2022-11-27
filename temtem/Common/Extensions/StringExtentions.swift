//
//  StringExtentions.swift
//  temtem
//
//  Created by Marlon Ansale on 11/14/22.
//

import Foundation

public extension String {
    static var urlBase:String {
        let urlBase = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String ?? ""
        return "https://" + urlBase
    }
}
