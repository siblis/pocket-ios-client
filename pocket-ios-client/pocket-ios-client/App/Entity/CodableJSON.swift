
//
//  CodableJSON.swift
//  pocket-ios-client
//
//  Created by Мак on 16/12/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

struct SignInResponse: Codable {
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decode(String.self, forKey: .token)
    }
}

struct SignUpResponse: Codable {
    var token: String
    var uid: Int
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
        case uid = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uid = try container.decode(Int.self, forKey: .uid)
        self.token = try container.decode(String.self, forKey: .token)
    }
}

struct DeleteContact: Codable {
    var uid: Int
    var username: String
    
    enum CodingKeys: String, CodingKey {
        case uid = "deleted_contact_id"
        case username = "deleted_contact_username"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uid = try container.decode(Int.self, forKey: .uid)
        self.username = try container.decode(String.self, forKey: .username)
    }
}

struct GroupInfo: Codable {
    var gid: Int
    var groupName: String
    var users: [Int]
    
    enum CodingKeys: String, CodingKey {
        case gid = "gid"
        case groupName = "group_name"
        case users = "users"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gid = try container.decode(Int.self, forKey: .gid)
        self.groupName = try container.decode(String.self, forKey: .groupName)
        self.users = try container.decode([Int].self, forKey: .users)
    }
}

