//
//  APIServiceImplementation.swift
//  temtem
//
//  Created by Marlon Ansale on 11/29/22.
//

import Foundation
import Combine

final public class APIServiceImplementation: APIService {

    private lazy var baseURL:URL = {
        URL(string: String.urlBase)!
    }()
    
    func dispatch(withAppendURL url:String) -> APIResultPublisher {
        let request = URLRequest(
            url: baseURL.appendingPathComponent(url)
        )
        
        return loadURL(withURLRequest: request)
            .subscribe(on: queueBackgroundInitiated)
            .eraseToAnyPublisher()
    }
    
}
