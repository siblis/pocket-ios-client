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

extension ChatViewController {
    func setupData() {
        let message0 = Message.init(receiver: "Группа стажировки GB", message: "Hello, how are you?", senderid: 123, senderName: "user", time: 12.30)
        let message1 = Message.init(receiver: "Группа стажировки GB", message: "Good morning", senderid: 123, senderName: "user", time: 12.35)
        let message2 = Message.init(receiver: "Группа стажировки GB", message: "fghjj", senderid: 123, senderName: "user", time: 12.40)
        
        testMessages = [message0, message1, message2]
    }
}
