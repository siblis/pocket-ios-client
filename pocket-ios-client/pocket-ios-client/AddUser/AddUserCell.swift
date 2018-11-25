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
    
    let diderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    
    
    override func setupViews() {
        addSubview(emailTextView)
        addSubview(diderLineView)
        
        
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: emailTextView)
        addConstraintsWithFormat(format: "V:[v0(40)]", views: emailTextView)
        addConstraint(NSLayoutConstraint(item: emailTextView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: diderLineView)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: diderLineView)
    }
    
}

extension AddUserController {
    
    func setupViews() {
        view.addSubview(inputTextContainerView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: inputTextContainerView)
        view.addConstraintsWithFormat(format: "V:[v0(48)]", views: inputTextContainerView)
        
        bottomConstraint = NSLayoutConstraint(item: inputTextContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint)
        
        view.addSubview(addButton)
        let centralXConstraint = NSLayoutConstraint(item: addButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centralYConstraint = NSLayoutConstraint(item: addButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -100)
        view.addConstraint(centralXConstraint)
        view.addConstraint(centralYConstraint)
    }
    
        func setupInputComponents() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        inputTextContainerView.addSubview(inputTextField)
        inputTextContainerView.addSubview(micButton)
        inputTextContainerView.addSubview(smileButton)
        inputTextContainerView.addSubview(topBorderView)
        
        inputTextContainerView.addConstraintsWithFormat(format: "H:|-8-[v0(40)][v1][v2(40)]-8-|", views:smileButton, inputTextField, micButton)
        
        inputTextContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: inputTextField)
        inputTextContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: micButton)
        inputTextContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: smileButton)
        inputTextContainerView.addConstraintsWithFormat(format: "H:|[v0]|", views: topBorderView)
        inputTextContainerView.addConstraintsWithFormat(format: "V:|[v0(0.5)]", views: topBorderView)
        
    }
    
    
}
