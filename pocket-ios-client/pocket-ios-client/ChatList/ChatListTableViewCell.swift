//
//  ChatListTableViewCell.swift
//  pocket-ios-client
//
//  Created by Damien on 08/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {
    

    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
   
    let nameLabel: UILabel = {
      let label = UILabel()
        label.text = "Steve Jobs"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Your friend's message and something else..."
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12.03 pm"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    let messageCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "24"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    

    func setup() {
         
        addSubview(profileImageView)
        
        setupContainerView()
        
        profileImageView.image = UIImage(named: "steveprofile")
        
        addConstraintsWithFormat(format: "H:|-12-[v0(68)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:[v0(68)]", views: profileImageView)
        
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

    }
    private func setupMessageCountView() {
        let messageCountView = UIView()
        addSubview(messageCountView)
            messageCountView.backgroundColor = #colorLiteral(red: 0.9584740996, green: 0.405867219, blue: 0.4054445624, alpha: 1)
            messageCountView.contentMode = .scaleAspectFill
            messageCountView.layer.cornerRadius = 14
            messageCountView.layer.masksToBounds = true
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
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        setupMessageCountView()
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)

        containerView.addConstraintsWithFormat(format: "H:|[v0][v1(80)]-12-|", views: nameLabel, timeLabel)
        containerView.addConstraintsWithFormat(format: "V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        containerView.addConstraintsWithFormat(format: "H:|[v0]-26-|", views: messageLabel)
        containerView.addConstraintsWithFormat(format: "V:|[v0(24)]", views: timeLabel)
    }
    
}
extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
