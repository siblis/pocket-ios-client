//
//  MessageCell.swift
//  pocket-ios-client
//
//  Created by Мак on 09/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class MessageCell: BaseCell {
    override func setupViews() {
        super.setupViews()
        
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
