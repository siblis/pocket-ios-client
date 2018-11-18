//
//  ChatListModel.swift
//  pocket-ios-client
//
//  Created by Юлия Чащина on 07/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

extension ChatListTableViewController {
    
    func setupData() {
        //        установила время в формате: n минут назад (-n * 60 секунд)
        let GB = UserContact.init(
            id: "777",
            account_name: "Группа стажировки GB",
            email: "",
            status: "",
            avatarImage: "team",
            firstName: "",
            lastName: ""
        )

        let chatMessage = ChatMessage.init(
            text: "В JSON на сервер отправляете ...",
            date: NSDate(),
            messageCount: "34",
            user: GB
        )
        
        let Voronin = UserContact.init(
            id: "888",
            account_name: "Evgeniy Voronin",
            email: "",
            status: "",
            avatarImage: "man",
            firstName: "",
            lastName: ""
        )
        
        let chatMessage1 = ChatMessage.init(
            text: "Адрес типа http://localhost:8888...",
            date: NSDate().addingTimeInterval(-2 * 60),
            messageCount: "2",
            user: Voronin
        )
        
        let Steve = UserContact.init(
            id: "555",
            account_name: "Steve Jobs",
            email: "",
            status: "",
            avatarImage: "steveprofile",
            firstName: "",
            lastName: ""
        )
        
        let chatMessage2 = ChatMessage.init(
            text: "Apple creates great IOS Devices for the world...",
            date: NSDate().addingTimeInterval(-60 * 60 * 24),
            messageCount: "86",
            user: Steve
        )
        
        let Geek = UserContact.init(
            id: "0",
            account_name: "Geek",
            email: "",
            status: "",
            avatarImage: "myProfile",
            firstName: "",
            lastName: ""
        )
        
        let chatMessage3 = ChatMessage.init(
            text: "hi everybody",
            date: NSDate().addingTimeInterval(-5 * 60 * 60 * 24 * 7),
            messageCount: "1",
            user: Geek
        )
        
        FakeData.chatMessages = [chatMessage, chatMessage1, chatMessage2, chatMessage3]
    }
}
