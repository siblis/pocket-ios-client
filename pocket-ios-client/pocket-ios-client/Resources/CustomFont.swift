//
//  CustomFont.swift
//  pocket-ios-client
//
//  Created by Мак on 16/01/2019.
//  Copyright © 2019 Damien Inc. All rights reserved.
//

import UIKit

extension UIFont {
    
    //MARK: Общий перечень шрифтов, которые используются в интерфейсе
    static let custF18 = systemFont(ofSize: 18)
    static let custF18M = systemFont(ofSize: 18, weight: .medium)
    static let custF17M = systemFont(ofSize: 17, weight: .medium)
    static let custF16 = systemFont(ofSize: 16)
    static let custF15L = systemFont(ofSize: 15, weight: .light)
    static let custF14 = systemFont(ofSize: 14)
    static let custF13R = systemFont(ofSize: 13, weight: .regular)
    static let custF12L = systemFont(ofSize: 12, weight: .light)
    static let custF11R = systemFont(ofSize: 11, weight: .regular)
    static let custFB12 = boldSystemFont(ofSize: 12)
    
    //MARK: Привязка шрифтов к местам где они использованы
    static let userListName = custF18
    static let userListStatus = custF14
    static let chatListName = custF18
    static let chatListMessage = custF14
    static let chatListTime = custF16
    static let chatListMessageCount = custFB12
    static let addUserName = custF18
    static let addUserEmail = custF14
    static let addUserId = custF14
    static let myProfName = custF18M
    static let myProfEmail = custF12L
    static let myProfId = custF12L
    static let myProfChat = custF11R
    static let myProfStat = custF13R
    static let myProfStFld = custF15L
    static let edtProfEdit = custF17M
    static let usrProfName = custF18M
    static let usrProfEmail = custF12L
    static let usrProfId = custF12L
    static let usrProfChat = custF11R
    static let usrProfStat = custF13R
    static let usrProfStFld = custF15L
    static let groupProfName = custF18M
    static let groupProfId = custF12L
    static let groupProfPart = custF16
    static let partCellName = custF14
    
}
