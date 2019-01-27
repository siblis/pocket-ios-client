//
//  GroupCell.swift
//  pocket-ios-client
//
//  Created by Anya on 17/01/2019.
//  Copyright © 2019 Damien Inc. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    let nameLabel = Interface().lblIni(font: UIFont.addUserName)
    let participantsLabel = Interface().lblIni(font: UIFont.addUserEmail, textColor: UIColor.textSecondary)
    let idLabel = Interface().lblIni(font: UIFont.addUserId, textColor: UIColor.textSecondary, textAlignment: .right)
    
    func setUp() {
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(participantsLabel)
        self.contentView.addSubview(idLabel)
        
        
        self.contentView.addConstraintsWithFormat(format: "H:|-84-[v0]-24-|", views: nameLabel)
        self.contentView.addConstraintsWithFormat(format: "H:|-84-[v0]-20-[v1(50)]-24-|", views: participantsLabel, idLabel)
        self.contentView.addConstraintsWithFormat(format: "V:|-5-[v0(18)]-[v1(14)]-6-|", views: nameLabel, participantsLabel)
        self.contentView.addConstraintsWithFormat(format: "V:|-5-[v0(18)]-[v1(14)]-6-|", views: nameLabel, idLabel)
        
    }
    
    func configure (group: GroupInfo) {
        self.idLabel.text = String(group.gid)
        self.nameLabel.text = group.groupName
        self.participantsLabel.text = "Участников: "+"\(group.users.count)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
