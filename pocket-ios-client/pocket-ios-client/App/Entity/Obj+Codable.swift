//
//  Obj+Codable.swift
//  pocket-ios-client
//
//  Created by Мак on 02/02/2019.
//  Copyright © 2019 Damien Inc. All rights reserved.
//

import Foundation
import RealmSwift

class UserProfile: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var userName: String = ""
    @objc dynamic var fullName: String = ""
    @objc dynamic var lastSeen: Double  = 0

    override class func primaryKey() -> String? {
        return "id"
    }

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case userName = "username"
        case fullName = "fullname"
        case lastSeen = "last_seen"
    }

    public convenience init(
        id: String,
        userName: String,
        fullName: String,
        lastSeen: Double
        ){
        self.init()
        self.id = id
        self.userName = userName
        self.fullName = fullName
        self.lastSeen = lastSeen
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let userName = try container.decode(String.self, forKey: .userName)
        let fullName = try container.decode(String.self, forKey: .fullName)
        let lastSeen = try container.decode(Double.self, forKey: .lastSeen)
        self.init(id: id, userName: userName, fullName: fullName, lastSeen: lastSeen)
    }
}

class User: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var profile = UserProfile()

    override class func primaryKey() -> String? {
        return "id"
    }

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case profile = "profile"
    }

    public convenience init(
        id: String,
        email: String,
        profile: UserProfile
        ){
        self.init()
        self.id = id
        self.email = email
        self.profile = profile
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let email = try container.decode(String.self, forKey: .email)
        let profile = try container.decode(UserProfile.self, forKey: .profile)
        self.init(id: id, email: email, profile: profile)
    }
}

class UserBlacklist: Object, Codable {
    @objc dynamic var user = UserProfile()

    private enum CodingKeys: String, CodingKey {
        case user = "user"
    }

    public convenience init(user: UserProfile){
        self.init()
        self.user = user
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let user = try container.decode(UserProfile.self, forKey: .user)
        self.init(user: user)
    }
}

class UserBlacklistCollection: Object, Decodable {
    @objc dynamic var user: String = ""
    @objc dynamic var offset: Int = 0
    var data = List<UserBlacklist>()

    override class func primaryKey() -> String? {
        return "user"
    }

    private enum CodingKeys: String, CodingKey {
        case user = "user"
        case offset = "offset"
        case data = "data"
    }

    public convenience init(
        user: String,
        offset: Int,
        data: List<UserBlacklist>
        ){
        self.init()
        self.user = user
        self.offset = offset
        self.data = data
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let user = try container.decode(String.self, forKey: .user)
        let offset = try container.decode(Int.self, forKey: .offset)
        let dataPars = try container.decode([UserBlacklist].self, forKey: .data)
        let data = List<UserBlacklist>()
        data.append(objectsIn: dataPars)
        self.init(user: user, offset: offset, data: data)
    }
}

class UserContact: Object, Codable {
    @objc dynamic var contact = UserProfile()
    @objc dynamic var byname: String = ""
    @objc dynamic var addedAt: Double = 0

    override class func primaryKey() -> String? {
        return "byname"
    }

    private enum CodingKeys: String, CodingKey {
        case contact = "contact"
        case byname = "byname"
        case addedAt = "added_at"
    }

    public convenience init(
        contact: UserProfile,
        byname: String,
        addedAt: Double
        ){
        self.init()
        self.contact = contact
        self.byname = byname
        self.addedAt = addedAt
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let contact = try container.decode(UserProfile.self, forKey: .contact)
        let byname = try container.decode(String.self, forKey: .byname)
        let addedAt = try container.decode(Double.self, forKey: .addedAt)
        self.init(contact: contact, byname: byname, addedAt: addedAt)
    }
}

class UserContactCollection: Object, Decodable {
    @objc dynamic var user: String = ""
    @objc dynamic var offset: Int = 0
    var data = List<UserContact>()

    override class func primaryKey() -> String? {
        return "user"
    }

    private enum CodingKeys: String, CodingKey {
        case user = "user"
        case offset = "offset"
        case data = "data"
    }

    public convenience init(
        user: String,
        offset: Int,
        data: List<UserContact>
        ){
        self.init()
        self.user = user
        self.offset = offset
        self.data = data
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let user = try container.decode(String.self, forKey: .user)
        let offset = try container.decode(Int.self, forKey: .offset)
        let dataPars = try container.decode([UserContact].self, forKey: .data)
        let data = List<UserContact>()
        data.append(objectsIn: dataPars)
        self.init(user: user, offset: offset, data: data)
    }
}

class Groupp: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var creator: String = ""
    @objc dynamic var space: String = ""
    @objc dynamic var name: String  = ""
    @objc dynamic var descript: String = ""
    @objc dynamic var invit: String = ""
    @objc dynamic var publ: Bool  = false

    override class func primaryKey() -> String? {
        return "id"
    }

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case creator = "creator"
        case space = "space"
        case name = "name"
        case descript = "description"
        case invit = "invitation_code"
        case publ = "public"
    }

    public convenience init(
        id: String,
        creator: String,
        space: String,
        name: String,
        descript: String,
        invit: String,
        publ: Bool
        ){
        self.init()
        self.id = id
        self.creator = creator
        self.space = space
        self.name = name
        self.descript = descript
        self.invit = invit
        self.publ = publ
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let creator = try container.decode(String.self, forKey: .creator)
        let space = try container.decode(String.self, forKey: .space)
        let name = try container.decode(String.self, forKey: .name)
        let descript = try container.decode(String.self, forKey: .descript)
        let invit = try container.decode(String.self, forKey: .invit)
        let publ = try container.decode(Bool.self, forKey: .publ)
        self.init(id: id, creator: creator, space: space, name: name, descript: descript, invit: invit, publ: publ)
    }
}

class UserChat: Object, Decodable {
    @objc dynamic var group: Groupp? = nil
    @objc dynamic var sender: UserProfile? = nil
    @objc dynamic var preview: String = ""
    @objc dynamic var unread: Int = 0

    private enum CodingKeys: String, CodingKey {
        case group = "group"
        case sender = "sender"
        case preview = "preview"
        case unread = "unread"
    }

    public convenience init(
        group: Groupp?,
        sender: UserProfile?,
        preview: String,
        unread: Int
        ){
        self.init()
        self.group = group
        self.sender = sender
        self.preview = preview
        self.unread = unread
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let group = try container.decode(Groupp.self, forKey: .group)
        let sender = try container.decode(UserProfile.self, forKey: .sender)
        let preview = try container.decode(String.self, forKey: .preview)
        let unread = try container.decode(Int.self, forKey: .unread)
        self.init(group: group, sender: sender, preview: preview, unread: unread)
    }
}

class UserChatCollection: Object, Decodable {
    @objc dynamic var offset: Int = 0
    var data = List<UserChat>()

    private enum CodingKeys: String, CodingKey {
        case offset = "offset"
        case data = "data"
    }

    public convenience init(
        offset: Int,
        data: List<UserChat>
        ){
        self.init()
        self.offset = offset
        self.data = data
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let offset = try container.decode(Int.self, forKey: .offset)
        let dataPars = try container.decode([UserChat].self, forKey: .data)
        let data = List<UserChat>()
        data.append(objectsIn: dataPars)
        self.init(offset: offset, data: data)
    }
}

class GroupMember: Object, Codable {
    @objc dynamic var user = UserProfile()
    @objc dynamic var role: String = ""

    private enum CodingKeys: String, CodingKey {
        case user = "user"
        case role = "role"
    }

    public convenience init(
        user: UserProfile,
        role: String
        ){
        self.init()
        self.user = user
        self.role = role
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let user = try container.decode(UserProfile.self, forKey: .user)
        let role = try container.decode(String.self, forKey: .role)
        self.init(user: user, role: role)
    }
}

class GroupMemberCollection: Object, Decodable {
    @objc dynamic var gId: String = ""
    @objc dynamic var offset: Int = 0
    var data = List<GroupMember>()

    private enum CodingKeys: String, CodingKey {
        case gId = "group_id"
        case offset = "offset"
        case data = "data"
    }

    public convenience init(
        gId: String,
        offset: Int,
        data: List<GroupMember>
        ){
        self.init()
        self.gId = gId
        self.offset = offset
        self.data = data
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let gId = try container.decode(String.self, forKey: .gId)
        let offset = try container.decode(Int.self, forKey: .offset)
        let dataPars = try container.decode([GroupMember].self, forKey: .data)
        let data = List<GroupMember>()
        data.append(objectsIn: dataPars)
        self.init(gId: gId, offset: offset, data: data)
    }
}

class Messag: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var sender: String = ""
    @objc dynamic var recipient: String?  = ""
    @objc dynamic var group: String? = ""
    @objc dynamic var text: String = ""
    @objc dynamic var read: Bool  = false
    @objc dynamic var time: Double  = 0

    override class func primaryKey() -> String? {
        return "id"
    }

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case sender = "sender"
        case recipient = "recipient"
        case group = "group"
        case text = "text"
        case read = "read"
        case time = "sent_at"
    }

    public convenience init(
        id: String,
        type: String,
        sender: String,
        recipient: String?,
        group: String?,
        text: String,
        read: Bool,
        time: Double
        ){
        self.init()
        self.id = id
        self.type = type
        self.sender = sender
        self.recipient = recipient
        self.group = group
        self.text = text
        self.read = read
        self.time = time
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let type = try container.decode(String.self, forKey: .type)
        let sender = try container.decode(String.self, forKey: .sender)
        let recipient = try container.decode(String.self, forKey: .recipient)
        let group = try container.decode(String.self, forKey: .group)
        let text = try container.decode(String.self, forKey: .text)
        let read = try container.decode(Bool.self, forKey: .read)
        let time = try container.decode(Double.self, forKey: .time)
        self.init(id: id, type: type, sender: sender, recipient: recipient,
                  group: group, text: text, read: read, time: time)
    }
}

class MessageCollection: Object, Decodable {
    @objc dynamic var offset: Int = 0
    var data = List<Messag>()

    private enum CodingKeys: String, CodingKey {
        case offset = "offset"
        case data = "data"
    }

    public convenience init(
        offset: Int,
        data: List<Messag>
        ){
        self.init()
        self.offset = offset
        self.data = data
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let offset = try container.decode(Int.self, forKey: .offset)
        let dataPars = try container.decode([Messag].self, forKey: .data)
        let data = List<Messag>()
        data.append(objectsIn: dataPars)
        self.init(offset: offset, data: data)
    }
}

class ValidationError: Object, Codable {
    @objc dynamic var err: String = ""

    private enum CodingKeys: String, CodingKey {
        case err = "fieldName"
    }

    public convenience init(err: String){
        self.init()
        self.err = err
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let err = try container.decode(String.self, forKey: .err)
        self.init(err: err)
    }
}

class ValidationErrorCollection: Object, Decodable {
    @objc dynamic var message: String = ""
    var data = List<ValidationError>()

    private enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }

    public convenience init(
        message: String,
        data: List<ValidationError>
        ){
        self.init()
        self.message = message
        self.data = data
    }

    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let message = try container.decode(String.self, forKey: .message)
        let dataPars = try container.decode([ValidationError].self, forKey: .data)
        let data = List<ValidationError>()
        data.append(objectsIn: dataPars)
        self.init(message: message, data: data)
    }
}
