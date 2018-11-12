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
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "Sample message"
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    let textBubbleView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        

        
        addSubview(textBubbleView)
        addSubview(messageTextView)

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
//        backgroundColor = UIColor.blue
        
    }
    
}
