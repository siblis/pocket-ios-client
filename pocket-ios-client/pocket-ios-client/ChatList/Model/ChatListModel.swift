//
//  ChatListModel.swift
//  pocket-ios-client
//
//  Created by Юлия Чащина on 07/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

class Friend: NSObject {
    var id: Int = 0
    var name: String?
    var profileImageName: String?
    var onlineStatus: String?
}


class ChatMessage: NSObject {
    var text: String?
    var date: NSDate?
    var messageCount: String?
    var friend: Friend?
}


extension ChatListTableViewController {
    
    func setupData() {
        //        установила время в формате: n минут назад (-n * 60 секунд)
        let GB = Friend()
        GB.id = 777
        GB.name = "Группа стажировки GB"
        GB.profileImageName = "team"
        
        let chatMessage = ChatMessage()
        chatMessage.friend = GB
        chatMessage.text = "В JSON на сервер отправляете ..."
        chatMessage.date = NSDate()
        chatMessage.messageCount = "34"
        
        let Voronin = Friend()
        Voronin.id = 888
        Voronin.name = "Evgeniy Voronin"
        Voronin.profileImageName = "man"
        
        let chatMessage1 = ChatMessage()
        chatMessage1.friend = Voronin
        chatMessage1.text = "Адрес типа http://localhost:8888..."
        chatMessage1.date = NSDate().addingTimeInterval(-2 * 60)
        chatMessage1.messageCount = "2"
        
        let Steve = Friend()
        Steve.id = 555
        Steve.name = "Steve Jobs"
        Steve.profileImageName = "steveprofile"
        
        let chatMessage2 = ChatMessage()
        chatMessage2.friend = Steve
        chatMessage2.text = "Apple creates great IOS Devices for the world..."
        chatMessage2.date = NSDate().addingTimeInterval(-60 * 60 * 24)
        chatMessage2.messageCount = "86"
        
        let Geek = Friend()
        Geek.name = "Geek"
        Geek.profileImageName = "myProfile"
        
        let chatMessage3 = ChatMessage()
        chatMessage3.friend = Geek
        chatMessage3.text = "hi everybody"
        chatMessage3.date = NSDate().addingTimeInterval(-5 * 60 * 60 * 24 * 7)
        chatMessage3.messageCount = "1"
        
        chatMessages = [chatMessage, chatMessage1, chatMessage2, chatMessage3]
    }
}
