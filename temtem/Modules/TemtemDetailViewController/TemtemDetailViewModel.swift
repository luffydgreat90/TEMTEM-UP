//
//  TemtemDetailViewModel.swift
//  temtem
//
//  Created by marlon von ansale on 02/11/2022.
//

import Foundation
import TemtemFeed
import Combine

public final class TemtemDetailViewModel {
	let temtemViewModel:TemtemViewModel
    let imageLoader: (URL) -> AnyPublisher<Data, Error>
    
	init(temtemViewModel: TemtemViewModel,
         imageLoader:@escaping (URL) -> AnyPublisher<Data, Error>) {
		self.temtemViewModel = temtemViewModel
        self.imageLoader = imageLoader
	}
	
}
