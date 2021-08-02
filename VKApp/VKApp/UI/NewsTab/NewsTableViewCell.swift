//
//  NewsTableViewCell.swift
//  Task1
//
//  Created by Pavel Khlebnikov on 12.07.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var news : MyNews? {
        didSet {
            newsImageAuthor.setCustomImage(news?.photoAuthor)
            authorLabel.text = news?.screenName
            
            textNewsLabel.text = news?.textNews
            
            likesLabel.text = "❤︎ \(news?.likes?.countLikes ?? 0)"
            repostLabel.text = "☞ \(news?.reposts?.countRepost ?? 0)"
            commentLabel.text = "✉︎ \(news?.comments?.countComments ?? 0)"
            numberOfViewstLabel.text = "❂ \(news?.views?.countViews ?? 0)"
        }
    }
    
    private let authorLabel : UILabel = {
        return FactoryUI.createLabel()
    }()
    
    private let likesLabel : UILabel = {
        return FactoryUI.createLabel()
    }()
    
    private let repostLabel : UILabel = {
        return FactoryUI.createLabel()
    }()
    
    private let commentLabel : UILabel = {
        return FactoryUI.createLabel()
    }()
    
    private let numberOfViewstLabel : UILabel = {
        return FactoryUI.createLabel()
    }()
    
    private let textNewsLabel : UILabel = {
        let lbl = FactoryUI.createLabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let newsImageAuthor : UIImageView = {
        return FactoryUI.createAvatarImageView()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(newsImageAuthor)
        newsImageAuthor.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 40, height: 40, enableInsets: false)
        addSubview(authorLabel)
        authorLabel.anchor(top: topAnchor, left: newsImageAuthor.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: bounds.size.width, height: 40, enableInsets: false)
        addSubview(textNewsLabel)
        textNewsLabel.anchor(top: authorLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: bounds.size.width, height: 0, enableInsets: false)
        
        let stackView = UIStackView(arrangedSubviews: [likesLabel, repostLabel, commentLabel, numberOfViewstLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 2
        addSubview(stackView)
        stackView.anchor(top: textNewsLabel.bottomAnchor, left: newsImageAuthor.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 10, width: 0, height: 40, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
