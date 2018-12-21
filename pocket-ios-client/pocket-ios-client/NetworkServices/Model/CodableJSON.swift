
//
//  CodableJSON.swift
//  pocket-ios-client
//
//  Created by Мак on 16/12/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

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
