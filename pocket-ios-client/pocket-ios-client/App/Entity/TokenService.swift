//
//  TokenService.swift
//  pocket-ios-client
//
//  Created by Damien on 07/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

class TokenService {
    
    static func getToken(forKey: String) -> String? {
        return UserDefaults.standard.string(forKey: forKey)
    }
    
    static func setToken(token: String?, forKey: String) {
        UserDefaults.standard.set(token, forKey: forKey)
    }
}
