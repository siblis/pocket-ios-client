//
//  UserCell.swift
//  pocket-ios-client
//
//  Created by Anya on 24/12/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    func setUp() {
        
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(emailLabel)
        self.contentView.addSubview(idLabel)
        
        self.contentView.addConstraintsWithFormat(format: "H:|-24-[v0(40)]", views: profileImageView)
        self.contentView.addConstraintsWithFormat(format: "V:[v0(40)]", views: profileImageView)
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        self.contentView.addConstraintsWithFormat(format: "H:[v0]-20-[v1]-24-|", views: profileImageView, nameLabel)
        self.contentView.addConstraintsWithFormat(format: "H:[v0]-20-[v1]-20-[v2(50)]-24-|", views: profileImageView, emailLabel, idLabel)
        self.contentView.addConstraintsWithFormat(format: "V:|-5-[v0(18)]-[v1(14)]-6-|", views: nameLabel, emailLabel)
        self.contentView.addConstraintsWithFormat(format: "V:|-5-[v0(18)]-[v1(14)]-6-|", views: nameLabel, idLabel)
       
    }
    
    func configure (user: ContactAccount) {
        self.idLabel.text = String(user.uid)
        self.nameLabel.text = user.accountName
        self.emailLabel.text = user.email
        self.profileImageView.image = UIImage(named: user.avatarImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
