//
//  ChatListTableViewCell.swift
//  pocket-ios-client
//
//  Created by Damien on 08/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {
    
    let profileImageView = Interface().imgIni(radius: 34)
    let nameLabel = Interface().lblIni(font: UIFont.chatListName)
    let messageLabel = Interface().lblIni(font: UIFont.chatListMessage, textColor: UIColor.textSecondary)
    let timeLabel = Interface().lblIni(font: UIFont.chatListTime, textAlignment: .right)
    let messageCountLabel = Interface().lblIni(
        font: UIFont.chatListMessageCount,
        textColor: UIColor.unreadMessageCountText,
        textAlignment: .center
    )
    
    func setup() {
         
        addSubview(profileImageView)
        
        setupContainerView()
        
        profileImageView.image = UIImage(named: "steveprofile")
        
        addConstraintsWithFormat(format: "H:|-12-[v0(68)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:[v0(68)]", views: profileImageView)
        
        addConstraint(NSLayoutConstraint(item: profileImageView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0))
    }
  
    private func setupMessageCountView() {
        let messageCountView = Interface().viewIni(color: UIColor.unreadMessageCounter, radius: 14)
        addSubview(messageCountView)
        messageCountView.contentMode = .scaleAspectFill
        
        addConstraintsWithFormat(format: "H:[v0(28)]-12-|", views: messageCountView)
        addConstraintsWithFormat(format: "V:[v0(28)]-12-|", views: messageCountView)
        
        messageCountView.addSubview(messageCountLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: messageCountLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: messageCountLabel)
    }
  
    private func setupContainerView() {
        let containerView = UIView()
       
        addSubview(containerView)
        addConstraintsWithFormat(format: "H:|-90-[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: containerView)
        addConstraint(NSLayoutConstraint(item: containerView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0))
        
        setupMessageCountView()
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)

        containerView.addConstraintsWithFormat(format: "H:|[v0][v1(80)]-12-|", views: nameLabel, timeLabel)
        containerView.addConstraintsWithFormat(format: "V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        containerView.addConstraintsWithFormat(format: "H:|[v0]-36-|", views: messageLabel)
        containerView.addConstraintsWithFormat(format: "V:|[v0(24)]", views: timeLabel)
    }
}
