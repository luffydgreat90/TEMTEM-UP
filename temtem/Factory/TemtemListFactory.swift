//
//  TemtemListFactory.swift
//  temtem
//
//  Created by Marlon Ansale on 11/23/22.
//

import UIKit
import TemtemFeed

public enum TemtemListFactory {
    public static func createTemtemListViewController(
        temtemService:TemtemService,
        selection:@escaping (TemtemViewModel) ->  Void)
    -> TemtemListViewController {
        let temtemListViewModel: TemtemListViewModel = TemtemListViewModel(
            temtemService: temtemService,
            selection: selection)
        
        return TemtemListViewController(
            view: TemtemListView(),
            viewModel: temtemListViewModel)
    }
}
