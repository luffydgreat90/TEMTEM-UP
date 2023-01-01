//
//  TemtemDetailFactory.swift
//  temtem
//
//  Created by Marlon Ansale on 11/25/22.
//

import UIKit
import TemtemFeed
import Combine

public enum TemtemDetailFactory {
    public static func createTemtemDetailViewController(
        temtemViewModel:TemtemViewModel,
        imageLoader: @escaping (URL) -> AnyPublisher<Data, Error>) -> TemtemDetailViewController {
        let temtemDetailViewModel = TemtemDetailViewModel(
            temtemViewModel: temtemViewModel,
            imageLoader: imageLoader)
        
        return TemtemDetailViewController(
            view: TemtemDetailView(imageLoader: imageLoader),
            viewModel: temtemDetailViewModel)
    }
}
