//
//  ElementUI.swift
//  pocket-ios-client
//
//  Created by Мак on 16/01/2019.
//  Copyright © 2019 Damien Inc. All rights reserved.
//

import UIKit

final class ElementUI {
    
    func lblIni(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment) -> UILabel {
        return lbl(font: font, textColor: textColor, textAlignment: textAlignment)
    }
    
    func lblIni(font: UIFont, textColor: UIColor) -> UILabel {
        return lbl(font: font, textColor: textColor, textAlignment: nil)
    }
    
    func lblIni(font: UIFont) -> UILabel {
        return lbl(font: font, textColor: nil, textAlignment: nil)
    }
    
    func lblIni(font: UIFont, textAlignment: NSTextAlignment) -> UILabel {
        return lbl(font: font, textColor: nil, textAlignment: textAlignment)
    }
    
    func imgIni(radius: CGFloat) -> UIImageView {
        return img(radius: radius, mask: true, img: nil)
    }
    
    func imgBubbleIni(image: UIImage) -> UIImageView {
        return img(radius: nil, mask: false, img: image)
    }
    
    func imgRoundIni() -> UIImageView {
        return img(radius: nil, mask: true, img: nil)
    }
    
    func viewIni(color: UIColor, radius: CGFloat) -> UIView {
        return view(color: color, radius: radius, mask: true)
    }
    
    func viewIni(color: UIColor) -> UIView {
        return view(color: color, radius: nil, mask: false)
    }
    
    func viewIni() -> UIView {
        return view(color: nil, radius: nil, mask: true)
    }
    
    func btnIni(textAlignment: NSTextAlignment) -> UIButton {
        return btn(textAlignment: textAlignment)
    }
    
    func btnIni() -> UIButton {
        return btn(textAlignment: nil)
    }
    
    func txtFldIni(holder: String, clearButtonMode: UITextField.ViewMode, tag: Int) -> UITextField {
        return txtFld(holder: holder, clearButtonMode: clearButtonMode, tag: tag)
    }
    
    func txtFldIni(holder: String, tag: Int) -> UITextField {
        return txtFld(holder: holder, clearButtonMode: nil, tag: tag)
    }
    
    func txtViewIni() -> UITextView {
        return txtView()
    }
    
    private func lbl(font: UIFont, textColor: UIColor?, textAlignment: NSTextAlignment?) -> UILabel {
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
    
    private func img(radius: CGFloat?, mask: Bool, img: UIImage?) -> UIImageView {
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
    
    private func view(color: UIColor?, radius: CGFloat?, mask: Bool) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        if let rad = radius {
            view.layer.cornerRadius = rad
        }
        view.layer.masksToBounds = mask
        return view
    }
    
    private func btn(textAlignment: NSTextAlignment?) -> UIButton {
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
    
    private func txtFld(holder: String, clearButtonMode: UITextField.ViewMode?, tag: Int) -> UITextField {
        let textField = UITextField()
        textField.placeholder = holder
        if let clr = clearButtonMode {
            textField.clearButtonMode = clr
        }
        textField.returnKeyType = .done
        textField.tag = tag
        return textField
    }
    
    private func txtView() -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "Sample message"
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = UIColor.clear
        return textView
    }
}
