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
    var text: String
    var senderid: Int
    var senderName: String
    var time: Double
    var isSender: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case receiver = "receiver"
        case text = "message"
        case senderid = "senderid"
        case senderName = "sender_name"
        case time = "timestamp"
    }
}

extension ChatViewController {
    func setupData() {
        let message0 = Message.init(receiver: "Группа стажировки GB", text: "Hello, how are you? Hope you are having a good morning", senderid: 123, senderName: "user", time: 12.30, isSender: false)
        let message1 = Message.init(receiver: "Группа стажировки GB", text: "Good morning...", senderid: 123, senderName: "user", time: 12.35, isSender: false)
        let message2 = Message.init(receiver: "Группа стажировки GB", text: "Are you interested in buying an Apple device? We have a wide variety of Apple devices that will suit your needs. Please make your purchase with us.", senderid: 123, senderName: "user", time: 12.40, isSender: false)
        
        testMessages = [message0, message1, message2]
    }
}
