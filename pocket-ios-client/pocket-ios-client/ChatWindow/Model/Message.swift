//
//  message.swift
//  pocket-ios-client
//
//  Created by Damien on 01/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

struct Message: Codable {
    
    var receiver: String
    var message: String
    var senderid: Int
    var senderName: String
    var time: Double
    
    enum CodingKeys: String, CodingKey {
        case receiver = "receiver"
        case message = "message"
        case senderid = "senderid"
        case senderName = "sender_name"
        case time = "timestamp"
    }
}
