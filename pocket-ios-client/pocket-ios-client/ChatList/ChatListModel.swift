//
//  ChatListModel.swift
//  pocket-ios-client
//
//  Created by Юлия Чащина on 07/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

class Friend: NSObject {
    var name: String?
    var profileImageName: String?
}


class ChatMessage: NSObject {
    var text: String?
    var date: NSDate?
    var messageCount: String?
    var friend: Friend?
}


extension ChatListTableViewController {
    
    func setupData() {
        let GB = Friend()
        GB.name = "Группа стажировки GB"
        GB.profileImageName = "team"
        
        let chatMessage = ChatMessage()
        chatMessage.friend = GB
        chatMessage.text = "В JSON на сервер отправляете ..."
        chatMessage.date = NSDate()
        chatMessage.messageCount = "34"
        
        let Voronin = Friend()
        Voronin.name = "Evgeniy Voronin"
        Voronin.profileImageName = "man"
        
        let chatMessage1 = ChatMessage()
        chatMessage1.friend = Voronin
        chatMessage1.text = "Адрес типа http://localhost:8888..."
        chatMessage1.date = NSDate()
        chatMessage1.messageCount = "2"
        
        let Steve = Friend()
        Steve.name = "Steve Jobs"
        Steve.profileImageName = "steveprofile"
        
        let chatMessage2 = ChatMessage()
        chatMessage2.friend = Steve
        chatMessage2.text = "Apple creates great IOS Devices for the world..."
        chatMessage2.date = NSDate()
        chatMessage2.messageCount = "86"
        
        chatMessages = [chatMessage, chatMessage1, chatMessage2]
    }
}
