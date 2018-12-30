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

        if let token = TokenService.getToken(forKey: "token") {
        //Блок инициализации начальных данных
            NetworkServices.getContacts(token: token) { (json, statusCode) in
                if statusCode == 200 {
                    WSS.initial.webSocketConnect()
                    DataBase().saveContacts(json: json)
                }
                else {
                    print("Error: \(statusCode)")
                }
            }
        }
    }

}
