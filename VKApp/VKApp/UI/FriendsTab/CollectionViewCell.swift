//
//  CollectionViewCell.swift
//  Task1
//
//  Created by macbook on 01.11.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    var likeView: UIView = UIView(frame: CGRect(x: 5, y: 5, width: 200, height: 200))
        
    var myImage: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "icons8-socrates-50"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.autoresizesSubviews = true
        return imgView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(myImage)
        myImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 200, height: 200, enableInsets: false)
        
        addSubview(likeView)
        likeView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 200, height: 200, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
