//
//  UserListTableViewCell.swift
//  pocket-ios-client
//
//  Created by Damien on 04/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let onlineStatusView: UIView = {
        let statusView = UIView()
        statusView.backgroundColor = UIColor.gray
        statusView.layer.cornerRadius = 5
        statusView.layer.masksToBounds = true
        return statusView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    func setUp() {
        
        let containerView = UIView()
        
        addSubview(containerView)
        addConstraintsWithFormat(format: "H:|-90-[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:[v0(40)]", views: containerView)
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(statusLabel)
        
        containerView.addConstraintsWithFormat(format: "H:|[v0]-24-|", views: nameLabel)
        containerView.addConstraintsWithFormat(format: "V:|[v0][v1(18)]|", views: nameLabel, statusLabel)
        containerView.addConstraintsWithFormat(format: "H:|[v0]-36-|", views: statusLabel)
        
        addSubview(profileImageView)
        addConstraintsWithFormat(format: "H:|-24-[v0(40)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:[v0(40)]", views: profileImageView)
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

        addSubview(onlineStatusView)
        addConstraintsWithFormat(format: "H:[v0(10)]-24-|", views: onlineStatusView)
        addConstraintsWithFormat(format: "V:[v0(10)]", views: onlineStatusView)
        addConstraint(NSLayoutConstraint(item: onlineStatusView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
