//
//  Interface.swift
//  pocket-ios-client
//
//  Created by Мак on 20/01/2019.
//  Copyright © 2019 Damien Inc. All rights reserved.
//

import UIKit

class Interface {
    
    let elemUI: AbstractElementUI = ElementUI()
    
    func lblIni(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment) -> UILabel {
        return elemUI.lbl(font: font, textColor: textColor, textAlignment: textAlignment)
    }
    
    func lblIni(font: UIFont, textColor: UIColor) -> UILabel {
        return elemUI.lbl(font: font, textColor: textColor, textAlignment: nil)
    }
    
    func lblIni(font: UIFont) -> UILabel {
        return elemUI.lbl(font: font, textColor: nil, textAlignment: nil)
    }
    
    func lblIni(font: UIFont, textAlignment: NSTextAlignment) -> UILabel {
        return elemUI.lbl(font: font, textColor: nil, textAlignment: textAlignment)
    }
    
    func imgIni(radius: CGFloat) -> UIImageView {
        return elemUI.img(radius: radius, mask: true, img: nil)
    }
    
    func imgBubbleIni(image: UIImage) -> UIImageView {
        return elemUI.img(radius: nil, mask: false, img: image)
    }
    
    func imgRoundIni() -> UIImageView {
        return elemUI.img(radius: nil, mask: true, img: nil)
    }
    
    func viewIni(color: UIColor, radius: CGFloat) -> UIView {
        return elemUI.view(color: color, radius: radius, mask: true)
    }
    
    func viewIni(color: UIColor) -> UIView {
        return elemUI.view(color: color, radius: nil, mask: false)
    }
    
    func viewIni() -> UIView {
        return elemUI.view(color: nil, radius: nil, mask: true)
    }
    
    func btnIni(textAlignment: NSTextAlignment) -> UIButton {
        return elemUI.btn(textAlignment: textAlignment)
    }
    
    func btnIni() -> UIButton {
        return elemUI.btn(textAlignment: nil)
    }
    
    func txtFldIni(holder: String, clearButtonMode: UITextField.ViewMode, tag: Int) -> UITextField {
        return elemUI.txtFld(holder: holder, clearButtonMode: clearButtonMode, tag: tag)
    }
    
    func txtFldIni(holder: String, tag: Int) -> UITextField {
        return elemUI.txtFld(holder: holder, clearButtonMode: nil, tag: tag)
    }
    
    func txtViewIni() -> UITextView {
        return elemUI.txtView()
    }
    
    //рисуем горизонтальную линию
    func drawLine(startX: Int, endX: Int, startY: Int, endY: Int, lineColor: UIColor, lineWidth: CGFloat, inView view: UIView) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: endX, y: endY))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        
        view.layer.addSublayer(shapeLayer)
    }
}
