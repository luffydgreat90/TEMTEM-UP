//
//  ImageCacheView.swift
//  temtem
//
//  Created by Marlon Ansale on 12/10/22.
//

import UIKit.UIImageView
import TemtemFeed

public final class ImageCacheView: UIImageView {
    private let imageCacheService:ImageCacheService
   
    init(withCache imageCacheService:ImageCacheService = ImageNSCacheService()) {
        self.imageCacheService = imageCacheService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
