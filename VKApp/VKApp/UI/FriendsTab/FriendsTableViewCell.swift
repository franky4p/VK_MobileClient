//
//  TableViewCell.swift
//  Task1
//
//  Created by macbook on 01.11.2020.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    var userNamelabel: UILabel = {
        return FactoryUI.createLabel()
    }()
    var userAvatar: UIImageView = {
        return FactoryUI.createAvatarImageView()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(userAvatar)
        userAvatar.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 40, height: 40, enableInsets: false)
        
        addSubview(userNamelabel)
        userNamelabel.anchor(top: topAnchor, left: userAvatar.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: bounds.size.width, height: 40, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
