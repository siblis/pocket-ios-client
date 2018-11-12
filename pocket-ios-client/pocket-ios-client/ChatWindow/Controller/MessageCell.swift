//
//  MessageCell.swift
//  pocket-ios-client
//
//  Created by Мак on 09/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class MessageCell: BaseCell {
    
    let messageTextView: UITextView = {
       let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = "Sample message"
        return textView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(messageTextView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: messageTextView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: messageTextView)
    }
    
    
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        backgroundColor = UIColor.blue
        
    }
    
}
