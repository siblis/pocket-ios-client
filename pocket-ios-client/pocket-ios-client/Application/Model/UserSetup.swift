//
//  UserSetup.swift
//  pocket-ios-client
//
//  Created by Мак on 19/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class UserSetup {
    
    func setToken(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    func getToken() -> String {
        return UserDefaults.standard.string(forKey: "token") ?? ""
    }
    
    func tokenIsEmpty() -> Bool {
        return UserDefaults.standard.string(forKey: "token") == nil
    }
}
