//
//  message.swift
//  pocket-ios-client
//
//  Created by Damien on 01/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

struct Message: Codable {
    
    var receiver: Int
    var message: String
    var senderid: Int
    var senderName: String
    
    enum CodingKeys: String, CodingKey {
        case receiver = "receiver"
        case message = "message"
        case senderid = "senderid"
        case senderName = "sender_name"
    }
}
