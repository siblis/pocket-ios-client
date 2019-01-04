//
//  CorrectionMethods.swift
//  pocket-ios-client
//
//  Created by Мак on 30/12/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

class CorrectionMethods {
    func autoLogIn() {
        let selfInfo = DataBase().loadSelfUser()
        URLServices().signIn(login: selfInfo.accountName, password: selfInfo.password) { (info) in
            if info.token != "" {
                Token.token = info.token
            } else {
                self.logOut()
            }
        }
    }
    
    func logOut() {
        Token.token = nil
        AdaptationDBJSON().deleteAllRecords()
        ApplicationSwitcherRC.initVC(choiceVC: .login)
    }
}
