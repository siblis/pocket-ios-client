//
//  MessageCell.swift
//  pocket-ios-client
//
//  Created by Мак on 09/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class MessageCell: BaseCell {
    
    static let leftBubbleImage = UIImage(named: "leftBubble")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    static let rightBubbleImage = UIImage(named: "rightBubble")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    
    let messageTextView = Interface().txtViewIni()
    let textBubbleView = Interface().viewIni()
    let bubbleImageView = Interface().imgBubbleIni(image: MessageCell.leftBubbleImage)
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textBubbleView)
        addSubview(messageTextView)
        textBubbleView.addSubview(bubbleImageView)
        textBubbleView.addConstraintsWithFormat(format: "H:|[v0]|", views: bubbleImageView)
        textBubbleView.addConstraintsWithFormat(format: "V:|[v0]|", views: bubbleImageView)

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
    }
}
