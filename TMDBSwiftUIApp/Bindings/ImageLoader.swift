//
//  ImageLoader.swift
//  TMDBSwiftUIApp
//
//  Created by Irtaza Fiaz on 23/06/2021.
//

import SwiftUI
import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading = false
    
    var imageCache = _imageCache
    
    
    func loadImage(with url: URL) {
        
        let urlString = url.absoluteURL
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = cachedImage
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            do {
                let data = try Data(contentsOf: url)
                guard let imageData = UIImage(data: data) else {
                    return
                }
                self.imageCache.setObject(imageData, forKey: urlString as AnyObject)
                DispatchQueue.main.async {
                    self.image = imageData
                }

            } catch {
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    
    
    
}
