//
//  User.swift
//  pocket-ios-client
//
//  Created by Damien on 30/09/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var account_name: String //поменяла let на var - заложила возможность сменить имя
    var password: String //поменяла let на var - заложила возможность сменить пароль
    let email: String
    
    //добавляю сюда все необходимые поля, чтобы потом проще переносить в реалм
    var firstName = ""
    var lastName = ""
    var uid = "0"
    var status = "userStatus"
    var photo = "selfPhoto"
    var token = ""
    
    
    init(account_name: String, password: String) {
        self.account_name = account_name
        TokenService.setToken(token: account_name, forKey: "account_name")
        self.email = TokenService.getToken(forKey: "email") ?? ""
        TokenService.setToken(token: email, forKey: "email")
        self.password = password
        TokenService.setToken(token: password, forKey: "password")
        TokenService.setToken(token: firstName, forKey: "firstName")
        TokenService.setToken(token: lastName, forKey: "lastName")
        TokenService.setToken(token: uid, forKey: "uid")
        TokenService.setToken(token: status, forKey: "status")
        TokenService.setToken(token: photo, forKey: "photo")
    }
    
    init(account_name: String, email: String, password: String) {
        self.account_name = account_name
        TokenService.setToken(token: account_name, forKey: "account_name")
        self.email = email
        TokenService.setToken(token: email, forKey: "email")
        self.password = password
        TokenService.setToken(token: password, forKey: "password")
        TokenService.setToken(token: firstName, forKey: "firstName")
        TokenService.setToken(token: lastName, forKey: "lastName")
        TokenService.setToken(token: uid, forKey: "uid")
        TokenService.setToken(token: status, forKey: "status")
        TokenService.setToken(token: photo, forKey: "photo")
    }
}
