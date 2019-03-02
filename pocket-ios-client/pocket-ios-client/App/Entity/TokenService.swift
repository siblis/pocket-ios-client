//
//  TokenService.swift
//  pocket-ios-client
//
//  Created by Mak on 11/01/2019.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

struct Token {
    
    static var main = UserDefaults.standard.string(forKey: "token") {
        didSet {
            UserDefaults.standard.set(main, forKey: "token")
            print ("set token = \(String(describing: main))")
        }
    }
}

