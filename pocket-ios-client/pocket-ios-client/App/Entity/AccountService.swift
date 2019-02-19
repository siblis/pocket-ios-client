//
//  AccountService.swift
//  pocket-ios-client
//
//  Created by Mak on 11/01/2019.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

struct Account {
    
    static var token = UserDefaults.standard.string(forKey: "token") ?? "" {
        didSet {
            UserDefaults.standard.set(token, forKey: "token")
            print("Token: \(String(describing: token))")
        }
    }
    
    static var name = UserDefaults.standard.string(forKey: "name") ?? "" {
        didSet {
            UserDefaults.standard.set(name, forKey: "name")
            print("Account name: \(String(describing: name))")
        }
    }
}

