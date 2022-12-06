//
//  TemtemDetailFactory.swift
//  temtem
//
//  Created by Marlon Ansale on 11/25/22.
//

import UIKit

public enum TemtemDetailFactory {
    public static func createTemtemDetailViewController(temtemViewModel:TemtemViewModel) -> TemtemDetailViewController {
        let temtemDetailViewModel = TemtemDetailViewModel(temtemViewModel: temtemViewModel)
        return TemtemDetailViewController(view: TemtemDetailView(), viewModel: temtemDetailViewModel)
    }
}
