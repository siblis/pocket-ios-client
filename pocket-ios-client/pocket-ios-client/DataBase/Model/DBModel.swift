//
//  DataBaseModel.swift
//  pocket-ios-client
//
//  Created by Damien on 13/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

struct Token {
    
    static var token: String?
    
}

struct UserSelf {
    
    static var id: String = ""
    static var account_name: String = ""
    static var email: String = ""
    static var avatarImage: String = ""
    
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
