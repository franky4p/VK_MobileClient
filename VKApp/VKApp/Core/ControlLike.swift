//
//  ControlLike.swift
//  Task1
//
//  Created by macbook on 08.11.2020.
//

import UIKit

class ControlLike: UIControl {

    var isLiked: Bool = false
    var counterLike: Int = 0
    let imageHeart = UIImageView(image: UIImage(named: "heart"))
    var labelLike = UILabel()
    
    override var isSelected: Bool {
        didSet {
            self.isLiked = !self.isLiked
            updateLikeColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imageHeart)
        
        self.addSubview(self.labelLike)
        self.labelLike.translatesAutoresizingMaskIntoConstraints = false
        
        let labelConstrY = self.labelLike.centerYAnchor.constraint(equalTo: self.imageHeart.centerYAnchor)
        let labelConstrX = self.labelLike.centerXAnchor.constraint(equalTo: self.imageHeart.centerXAnchor)
        
        labelConstrY.isActive = true
        labelConstrX.isActive = true
        
        self.labelLike.text = "\(self.counterLike)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLikeColor() {
        if isLiked {
            imageHeart.tintColor = UIColor.red
        } else {
            imageHeart.tintColor = UIColor.gray
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {self.imageHeart.transform = CGAffineTransform(translationX: 2, y: 2)}, completion: {_ in self.imageHeart.transform = .identity})
        
        self.labelLike.text = "\(self.counterLike)"
    }
}
