//
//  StringExtentions.swift
//  temtem
//
//  Created by MacPro on 11/14/22.
//

import Foundation

extension String {
    static var urlBase:String {
        let urlBase = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String ?? ""
        return "https://" + urlBase
    }
}
