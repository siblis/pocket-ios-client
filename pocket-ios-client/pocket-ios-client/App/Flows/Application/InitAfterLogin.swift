//
//  InitAfterLogin.swift
//  pocket-ios-client
//
//  Created by Мак on 18/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit
import RealmSwift

class InitAfterLogin: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let token = Token.main {
        //Блок инициализации начальных данных
            URLServices().getContacts(token: token) { (contacts) in
                WSS.initial.webSocketConnect()
                DataBase().saveContacts(data: contacts)
            }
        }
    }

}
