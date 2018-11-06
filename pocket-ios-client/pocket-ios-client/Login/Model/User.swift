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
    
    init(account_name: String, password: String) {
        self.account_name = account_name
        self.email = UserDefaults.standard.string(forKey: "selfEmail") ?? ""
        self.password = password
    }
    
    init(account_name: String, email: String, password: String) {
        self.account_name = account_name
        self.email = email
        self.password = password
    }
    
}
