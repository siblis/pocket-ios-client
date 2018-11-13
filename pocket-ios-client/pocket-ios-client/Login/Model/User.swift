//
//  User.swift
//  pocket-ios-client
//
//  Created by Damien on 30/09/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

struct User: Codable {
    
    static var account_name = TokenService.getToken(forKey: "account_name") ?? "" {
        didSet {
            TokenService.setToken(token: account_name, forKey: "account_name")
            print ("set account_name = \(TokenService.getToken(forKey: "account_name")!)")
        }
    }
    static var password = TokenService.getToken(forKey: "password") ?? "1" {
        didSet {
            TokenService.setToken(token: password, forKey: "password")
            print ("set password = \(TokenService.getToken(forKey: "password")!)")
        }
    }
    static var email = TokenService.getToken(forKey: "email") ?? "@" {
        didSet {
            TokenService.setToken(token: email, forKey: "email")
            print ("set email = \(TokenService.getToken(forKey: "email")!)")
        }
    }
    static var token = TokenService.getToken(forKey: "token") ?? "" {
        didSet {
            TokenService.setToken(token: token, forKey: "token")
            print ("set token = \(TokenService.getToken(forKey: "token")!)")
        }
    }
    
    static var uid = TokenService.getToken(forKey: "token") ?? "0" {
        didSet {
            TokenService.setToken(token: uid, forKey: "uid")
            print ("set uid = \(TokenService.getToken(forKey: "uid")!)")
        }
    }
    
    static var firstName = ""
    static var lastName = ""
    static var status = "Как-то так"
    static var photo = "myProfile"
    
}
