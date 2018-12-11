//
//  InitAfterLogin.swift
//  pocket-ios-client
//
//  Created by Мак on 18/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class InitAfterLogin: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Блок инициализации начальных данных
        WSS.initial.webSocketConnect()
        ChatListTableViewController().setupData()
    }

}
