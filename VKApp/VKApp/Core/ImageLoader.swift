//
//  ImageLoader.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 22.07.2021.
//

import UIKit

final class ImageLoader {
    static private let cache = NSCache<NSString, UIImage>()
    
    static private func loadImage(urlString: String, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global().async {
            let url = URL(string: urlString)!
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    static func getImage(_ imgURLString: String, complition: @escaping (UIImage?) -> ()) {
        let itemURL = NSString(string: imgURLString)
        
        if let cachedImage = cache.object(forKey: itemURL) {
            complition(cachedImage)
        } else {
            loadImage(urlString:imgURLString) { (loadImage) in
                guard let loadImage = loadImage else { return }
                
                cache.setObject(loadImage, forKey: itemURL)
                complition(loadImage)
            }
        }
    }
    
}
