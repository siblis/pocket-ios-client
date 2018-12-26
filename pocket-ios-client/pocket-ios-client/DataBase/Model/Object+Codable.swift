//
//  Object+Codable.swift
//  pocket-ios-client
//
//  Created by Mak on 13/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

struct Token {
    
    static var token = TokenService.getToken(forKey: "token") {
        didSet {
            TokenService.setToken(token: token, forKey: "token")
            print ("set token = \(String(describing: TokenService.getToken(forKey: "token")))")
        }
    }
}

//MARK: Модель собственного профиля (Login, SignUp, MyProfile)
class SelfAccount: Object, Codable {
    @objc dynamic var uid: Int = 0
    @objc dynamic var accountName: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var password: String  = ""
    @objc dynamic var avatarImage: String  = "myProfile"
    
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var status: String = ""
    
    override class func primaryKey() -> String? {
        return "accountName"
    }
    
    private enum CodingKeys: String, CodingKey {
        case uid = "user_id"
        case accountName = "account_name"
        case email = "email"
    }
    
    public convenience init(
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

//MARK: Модель аккаунта контакта (UserList)
class ContactAccount: Object, Codable {
    @objc dynamic var uid: Int = 0
    @objc dynamic var accountName: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var avatarImage: String  = "man"
    
    override class func primaryKey() -> String? {
        return "uid"
    }
    
    private enum CodingKeys: String, CodingKey {
        case uid = "user_id"
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
    
    public required convenience init(json: JSON) {
        self.init()
        
        
    }
}

//MARK: Модель групп ()
class Group: Object, Decodable {
    @objc dynamic var gid: Int = 0
    @objc dynamic var groupName: String = ""
    var users = List<ContactAccount>()
    
    override class func primaryKey() -> String? {
        return "gid"
    }
    
    private enum CodingKeys: String, CodingKey {
        case gid = "group_id"
        case groupName = "group_name"
        case users = "users"
    }
    
    public required convenience init(
        gid: Int,
        groupName: String,
        users: List<ContactAccount>
        ){
        self.init()
        self.gid = gid
        self.groupName = groupName
        self.users = users
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let gid = try container.decode(Int.self, forKey: .gid)
        let groupName = try container.decode(String.self, forKey: .groupName)
        let usersArray = try container.decode([ContactAccount].self, forKey: .users)
        let users = List<ContactAccount>()
        users.append(objectsIn: usersArray)
        self.init(gid: gid, groupName: groupName, users: users)
    }
}

//MARK: Модель чатов (ChatList)
class Chat: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var chatName: String = ""
    @objc dynamic var messageCount: Int = 0
    var messages = List<Message>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    public required convenience init(
        id: Int,
        chatName: String,
        messageCount: Int,
        messages: [Message]
        ){
        self.init()
        self.id = id
        self.chatName = chatName
        self.messageCount = messageCount
        self.messages.append(objectsIn: messages)
    }
}

//MARK: Модель сообщений (ChatWindow)
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
