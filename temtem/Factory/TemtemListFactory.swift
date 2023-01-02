//
//  TemtemListFactory.swift
//  temtem
//
//  Created by Marlon Ansale on 11/23/22.
//

import UIKit
import TemtemFeed
import Combine

public enum TemtemListFactory {
    public static func createTemtemListViewController(
        temtemService:TemtemService,
        imageLoader:@escaping (URL) -> AnyPublisher<Data, Error>,
        selection:@escaping (TemtemViewModel) ->  Void)
    -> TemtemListViewController {
        let temtemListViewModel: TemtemListViewModel = TemtemListViewModel(
            temtemService: temtemService,
            imageLoader: imageLoader,
            selection: selection)
        
        return TemtemListViewController(
            view: TemtemListView(),
            viewModel: temtemListViewModel)
    }
}
