//
//  ImageCacheView.swift
//  temtem
//
//  Created by Marlon Ansale on 12/10/22.
//

import UIKit.UIImageView
import Combine
import TemtemFeed

public final class ImageCacheView: UIImageView {
    private let imageCacheService: ImageCacheService
    private let imageDataService: ImageDataService
    private var cancellable: Cancellable?
   
    init(imageCacheService:ImageCacheService = ImageNSCacheService(), imageDataService:ImageDataService = ImageURLSessionDataService()) {
        self.imageCacheService = imageCacheService
        self.imageDataService = imageDataService
        super.init(frame: .zero)
        
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func loadImage(withURL url:URL?){
        guard let url = url else{
            return
        }
        
        if let data = try? imageCacheService.retrieve(dataForURL: url) {
            self.setImage(image: UIImage(data: data))
        }else{
            cancellable = imageDataService
                .loadImage(withURL: url)
                .receive(on: queueInitiated)
                .sink(receiveCompletion: { _ in
                    
                }, receiveValue: { [weak self] data in
                    try? self?.imageCacheService.insert(data, for: url)
                    self?.setImage(image: UIImage(data: data))
                })
        }
    }
    
    public func cancelImageRequest() {
        cancellable?.cancel()
        self.image = nil
    }
}
