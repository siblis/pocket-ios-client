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

        let token = TokenService.getToken(forKey: "token")
        //Блок инициализации начальных данных
        NetworkServices.getSelfUser(token: token!) { (json, statusCode) in
            if statusCode == 200 {
                DataBase.saveSelfUser(json: json)
                DataBase.instance.loadAllContactsFromDB(keyId: UserSelf.uid)
                WSS.initial.webSocketConnect()
                ChatListTableViewController().setupData()
            }
            else {
                //Костыль на случай протухания токена
                TokenService.setToken(token: nil, forKey: "token")
                DispatchQueue.main.async {
                    ApplicationSwitcherRC.initVC(choiseVC: .login)
                }
            }
        }
        
    }

}
