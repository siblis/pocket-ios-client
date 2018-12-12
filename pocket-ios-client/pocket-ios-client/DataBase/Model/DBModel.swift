//
//  DataBaseModel.swift
//  pocket-ios-client
//
//  Created by Damien on 13/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation
import RealmSwift


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
    static var accountName: String = ""
    static var email: String = ""
    static var password: String = ""
    static var avatarImage: String = "noPhoto"

    static var firstName = ""
    static var lastName = ""
    static var status = ""

}

struct UserContact {
    
    var id: Int = 0
    var account_name: String = ""
    var email: String = ""
    var status: String = ""
    var avatarImage: String = "noPhoto"
    
    var firstName = ""
    var lastName = ""
    var participants: [Int] = []
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

//MARK: Парсинг аккаунта контакта и модель для реалма

class ContactAccount: Object, Codable {
    @objc dynamic var uid: Int = 0
    @objc dynamic var accountName: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var status: String  = ""
    @objc dynamic var avatarImage: String  = "noPhoto"
    
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    
    override class func primaryKey() -> String? {
        return "uid"
    }
    
    private enum CodingKeys: String, CodingKey {
        case uid = "uid"
        case accountName = "account_name"
        case email = "email"
    }
    
    public required convenience init(
        uid: Int,
        accountName: String,
        email: String
        ){
        self.init()
        self.uid = uid
        self.accountName = accountName
        self.email = email
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let uid = try container.decode(Int.self, forKey: .uid)
        let accountName = try container.decode(String.self, forKey: .accountName)
        let email = try container.decode(String.self, forKey: .email)
        self.init(uid: uid, accountName: accountName, email: email)
    }
}

//MARK: Парсинг собственного профиля и модель для реалма
class SelfAccount: Object, Codable {
    @objc dynamic var uid: Int = 0
    @objc dynamic var accountName: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var password: String  = ""
    @objc dynamic var avatarImage: String  = "noPhoto"
    
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var status: String = ""
    
    override class func primaryKey() -> String? {
        return "uid"
    }
    
    private enum CodingKeys: String, CodingKey {
        case uid = "uid"
        case accountName = "account_name"
        case email = "email"
    }
    
    public required convenience init(
        uid: Int,
        accountName: String,
        email: String
        ){
        self.init()
        self.uid = uid
        self.accountName = accountName
        self.email = email
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let uid = try container.decode(Int.self, forKey: .uid)
        let accountName = try container.decode(String.self, forKey: .accountName)
        let email = try container.decode(String.self, forKey: .email)
        self.init(uid: uid, accountName: accountName, email: email)
    }
}

//MARK: Парсинг сообщений и модель для реалма
class Message: Object, Codable {
    @objc dynamic var receiver: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var senderid: Int = 0
    @objc dynamic var senderName: String  = ""
    @objc dynamic var time: String  = ""
    @objc dynamic var isEnemy: Bool = true
    
    override class func primaryKey() -> String? {
        return "time"
    }
    
    private enum CodingKeys: String, CodingKey {
        case receiver = "receiver"
        case text = "message"
        case senderid = "senderid"
        case senderName = "sender_name"
        case time = "timestamp"
    }
    
    public required convenience init(
        receiver: Int,
        text: String,
        senderid: Int,
        senderName: String,
        time: Double,
        isEnemy: Bool = true
    ){
        self.init()
        self.receiver = receiver
        self.text = text
        self.senderid = senderid
        self.senderName = senderName
        self.time = dateFormater(time)
        self.isEnemy = isEnemy
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let receiver = try container.decode(Int.self, forKey: .receiver)
        let text = try container.decode(String.self, forKey: .text)
        let senderid = try container.decode(Int.self, forKey: .senderid)
        let senderName = try container.decode(String.self, forKey: .senderName)
        let time = try container.decode(Double.self, forKey: .time)
        self.init(receiver: receiver, text: text, senderid: senderid, senderName: senderName, time: time)
    }
    
    private func dateFormater(_ time: Double) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = TimeZone.current
        let localDate = dateFormatter.string(from: date as Date)
        return localDate
    }
}
