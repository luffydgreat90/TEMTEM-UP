//
//  CollectionExtension.swift
//  temtem
//
//  Created by Marlon Ansale on 12/20/22.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
