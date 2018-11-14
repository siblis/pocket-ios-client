//
//  DataBaseModel.swift
//  pocket-ios-client
//
//  Created by Damien on 13/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

struct Token {
    
    static var token = TokenService.getToken(forKey: "token") {
        didSet {
            TokenService.setToken(token: token, forKey: "token")
            print ("set token = \(TokenService.getToken(forKey: "token")!)")
        }
    }
    
}

struct UserSelf {
    
    static var uid: String = ""
    static var account_name: String = ""
    static var email: String = ""
    static var password: String = ""
    static var avatarImage: String = ""
    
    static var firstName = ""
    static var lastName = ""
    static var status = ""
    
}

struct UserContact {
    
    var id: String? = ""
    var account_name: String? = ""
    var email: String? = ""
    var status: String? = ""
    var avatarImage: String?
    
}

struct Contacts {
    
    static var list = [UserContact]()
    
}

struct Chats {
    
    static var list = [Int:UserContact]()
    
}
