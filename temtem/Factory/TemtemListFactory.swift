//
//  TemtemListFactory.swift
//  temtem
//
//  Created by Marlon Ansale on 11/23/22.
//

import UIKit

public struct TemtemListFactory {
    public static func createTemtemListViewController(temtemService:TemtemService) -> TemtemListViewController {
        let temtemListViewModel: TemtemListViewModel = TemtemListViewModel(temtemService: temtemService)
        return TemtemListViewController(view: TemtemListView(),viewModel: temtemListViewModel)
    }
}
