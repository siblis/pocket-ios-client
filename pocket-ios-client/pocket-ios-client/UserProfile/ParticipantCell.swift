//
//  ParticipantCell.swift
//  pocket-ios-client
//
//  Created by Anya on 19/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class ParticipantCell: UITableViewCell {
    
    let onlineStatusView: UIView = {
        let statusView = UIView()
        statusView.backgroundColor = UIColor.gray
        statusView.layer.cornerRadius = 5
        statusView.layer.masksToBounds = true
        return statusView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        label.textAlignment = .left
        return label
    }()
    
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
