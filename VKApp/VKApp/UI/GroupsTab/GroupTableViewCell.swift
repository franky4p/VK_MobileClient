//
//  TableViewCellGroup.swift
//  Task1
//
//  Created by macbook on 01.11.2020.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    var groupNameLabel: UILabel = {
        return FactoryUI.createLabel()
    }()
    var avatarGropImageView: UIImageView = {
        return FactoryUI.createAvatarImageView()
    }()
    
    let animationView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(avatarGropImageView)
        avatarGropImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 40, height: 40, enableInsets: false)
        
        addSubview(groupNameLabel)
        groupNameLabel.anchor(top: topAnchor, left: avatarGropImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: bounds.size.width, height: 40, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            UIView.animate(withDuration: 2.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {self.avatarGropImageView.frame.size = CGSize(width: 70, height: 70)}, completion: {_ in self.avatarGropImageView.transform = .identity})
        }
    }
}
