//
//  AbstractElementUI.swift
//  pocket-ios-client
//
//  Created by Мак on 16/01/2019.
//  Copyright © 2019 Damien Inc. All rights reserved.
//

import UIKit

protocol AbstractElementUI: class {
    func lbl(font: UIFont, textColor: UIColor?, textAlignment: NSTextAlignment?) -> UILabel
    func img(radius: CGFloat?, mask: Bool, img: UIImage?) -> UIImageView
    func view(color: UIColor?, radius: CGFloat?, mask: Bool) -> UIView
    func btn(textAlignment: NSTextAlignment?) -> UIButton
    func txtFld(holder: String, clearButtonMode: UITextField.ViewMode?, tag: Int) -> UITextField
    func txtView() -> UITextView
}

final class ElementUI: AbstractElementUI {
    
    func lbl(font: UIFont, textColor: UIColor?, textAlignment: NSTextAlignment?) -> UILabel {
        let label = UILabel()
        if let color = textColor {
            label.textColor = color
        }
        if let aligment = textAlignment {
            label.textAlignment = aligment
        }
        label.font = font
        return label
    }
    
    func img(radius: CGFloat?, mask: Bool, img: UIImage?) -> UIImageView {
        let image = UIImageView()
        if let img = img {
            image.image = img
            image.tintColor = UIColor.chatBubbleEnemy
        } else {
            image.contentMode = .scaleAspectFill
            image.layer.masksToBounds = mask
            if let rad = radius {
                image.layer.cornerRadius = rad
            } else {
                image.layer.cornerRadius = image.frame.size.width/2
            }
        }
        return image
    }
    
    func view(color: UIColor?, radius: CGFloat?, mask: Bool) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        if let rad = radius {
            view.layer.cornerRadius = rad
        }
        view.layer.masksToBounds = mask
        return view
    }
    
    func btn(textAlignment: NSTextAlignment?) -> UIButton {
        let button = UIButton()
        if let alignment = textAlignment {
            button.setTitleColor(UIColor.buttonPrimary, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            button.titleLabel?.textAlignment = alignment
        } else {
            button.imageView?.contentMode = .scaleAspectFill
            button.imageView?.layer.masksToBounds = true
        }
        return button
    }
    
    func txtFld(holder: String, clearButtonMode: UITextField.ViewMode?, tag: Int) -> UITextField {
        let textField = UITextField()
        textField.placeholder = holder
        if let clr = clearButtonMode {
            textField.clearButtonMode = clr
        }
        textField.returnKeyType = .done
        textField.tag = tag
        return textField
    }
    
    func txtView() -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "Sample message"
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = UIColor.clear
        return textView
    }
}
