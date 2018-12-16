//
//  AddUserCell.swift
//  pocket-ios-client
//
//  Created by Юлия Чащина on 24/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation
import UIKit

class AddUserCell: BaseCell {
    
    let emailTextView: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Введите e-mail"
        textfield.borderStyle = .roundedRect
        //        textView.font = UIFont.systemFont(ofSize: 18)
        
        return textfield
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    
    override func setupViews() {
        addSubview(emailTextView)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: emailTextView)
        addConstraintsWithFormat(format: "V:[v0(40)]", views: emailTextView)
        addConstraint(NSLayoutConstraint(item: emailTextView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: dividerLineView)
    }
    
}


