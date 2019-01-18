//
//  ParticipantCell.swift
//  pocket-ios-client
//
//  Created by Anya on 19/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class ParticipantCell: UITableViewCell {
    
    let onlineStatusView = ElementUI().viewIni(color: UIColor.statusOffLine, radius: 5)
    
    let nameLabel = ElementUI().lblIni(
        font: UIFont.partCellName,
        textColor: UIColor.textPrimary,
        textAlignment: .left
    )
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp () {
        self.contentView.addSubview(onlineStatusView)
        self.contentView.addSubview(nameLabel)
        
        self.contentView.addConstraintsWithFormat(format: "V:[v0(10)]", views: onlineStatusView)
        onlineStatusView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.contentView.addConstraintsWithFormat(format: "V:[v0(24)]", views: nameLabel)
        nameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.contentView.addConstraintsWithFormat(format: "|-12-[v0(10)]-13-[v1]-20-|", views: onlineStatusView, nameLabel)
    }
    
    func setUpContents (name: String) {
        nameLabel.text = name
    }

}
