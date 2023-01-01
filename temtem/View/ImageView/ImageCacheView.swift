//
//  ImageCacheView.swift
//  temtem
//
//  Created by Marlon Ansale on 12/10/22.
//

import UIKit
import Combine
import TemtemFeed

public final class ImageCacheView: UIImageView {
    private var cancellable: Cancellable?

    init() {
        super.init(frame: .zero)
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func loadImage(withURL url:URL?, imageLoader: ((URL) -> AnyPublisher<Data, Error>)?){
        guard let url = url, let imageLoader = imageLoader else{
            return
        }
        
        cancellable = imageLoader(url)
            .dispatchOnMainQueue()
            .sink(receiveCompletion: {  completion in
            switch completion {
            case .finished: break

            case .failure: break
            }
        }, receiveValue: { [weak self] data in
            self?.setImage(image: UIImage(data: data))
        })
        
    }
    
    public func cancelImageRequest() {
        cancellable?.cancel()
        self.image = nil
    }
}
