//
//  TemtemListFactory.swift
//  temtem
//
//  Created by Marlon Ansale on 11/23/22.
//

import UIKit

public enum TemtemListFactory {
    public static func createTemtemListViewController(temtemService:TemtemService) -> TemtemListViewController {
        let temtemListViewModel: TemtemListViewModel = TemtemListViewModel(temtemService: temtemService)
        return TemtemListViewController(view: TemtemListView(),viewModel: temtemListViewModel)
    }
}
