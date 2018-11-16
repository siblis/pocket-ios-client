//
//  message.swift
//  pocket-ios-client
//
//  Created by Damien on 01/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

extension ChatViewController {
    func setupData() {
        let message0 = Message.init(receiver: "777", text: "Hello, how are you? Hope you are having a good morning", senderid: 123, senderName: "user", time: 12.30, isEnemy: false)
        let message1 = Message.init(receiver: "Группа стажировки GB", text: "Good morning...", senderid: 555, senderName: "user", time: 12.35, isEnemy: true)
        let message2 = Message.init(receiver: "Группа стажировки GB", text: "Are you interested in buying an Apple device? We have a wide variety of Apple devices that will suit your needs. Please make your purchase with us.", senderid: 777, senderName: "user", time: 12.40, isEnemy: true)
        
        FakeData.testMessages = [message0, message1, message2]
    }
}
