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
    var avatarImage: String? = ""
    
    var firstName = ""
    var lastName = ""
}

struct Contacts {
    
    static var list = [UserContact]()
    
}

struct Chats {
    
    static var list = [Int:UserContact]()
    
}

struct ChatMessage {
    var text: String?
    var date: NSDate?
    var messageCount: String?
    var user: UserContact?
}

struct Message: Codable {
    
    var receiver: String
    var text: String
    var senderid: Int
    var senderName: String
    var time: Double
    var isEnemy: Bool = true
    
    enum CodingKeys: String, CodingKey {
        case receiver = "receiver"
        case text = "message"
        case senderid = "senderid"
        case senderName = "sender_name"
        case time = "timestamp"
    }
}
