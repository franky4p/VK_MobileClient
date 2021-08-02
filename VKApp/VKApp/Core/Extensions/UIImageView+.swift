//
//  UIImageView+.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 22.07.2021.
//

import UIKit

extension UIImageView {
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "icons8-socrates-50")
            return
        }
        
        DispatchQueue.main.async {
            ImageLoader.getImage(imageURLString) { (image) in
                self.image = image
            }
        }
    }
}
