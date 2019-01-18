//
//  DataBase.swift
//  pocket-ios-client
//
//  Created by Mak on 05/12/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation
import RealmSwift

class DataBase {
    
    func saveSelfUser(info: SelfAccount) {
        var password: String = info.password
        if let sDB = loadSelfUser() {
            password = sDB.password
        }
        let selfInf = SelfAccount.init(
            uid: info.uid,
            accountName: info.accountName,
            email: info.email,
            password: password
        )
        AdaptationDBJSON().saveInDB([selfInf])
    }
    
    func loadSelfUser() -> SelfAccount? {
        return AdaptationDBJSON().loadFromDB(smTableDB: SelfAccount.self).first
    }
    
    func observerSelfUser() -> NotificationToken? {
        let smInfoFromDB = AdaptationDBJSON().loadFromDB(smTableDB: SelfAccount.self)
        return AdaptationDBJSON().realmObserver(smTableDB: smInfoFromDB) { (changes) in
            switch changes {
            case .initial, .update:
                print("Load self data")
            case .error(let error):
                print(error)
            }
        }
    }
    
    func saveContacts(data: [ContactAccount]) {
        if let selfInfo = loadSelfUser() {
            let contacts = data.filter { $0.email != selfInfo.email }
            AdaptationDBJSON().saveInDB(contacts)
        }
    }
    
    func observerContacts(complition: @escaping (RealmCollectionChange<Results<ContactAccount>>) -> Void) -> NotificationToken? {
        
        let smInfoFromDB = AdaptationDBJSON().loadFromDB(smTableDB: ContactAccount.self)
        return AdaptationDBJSON().realmObserver(smTableDB: smInfoFromDB, complition: complition)
    }
    
    func loadContactsList() -> Results<ContactAccount> {
        return AdaptationDBJSON().loadFromDB(smTableDB: ContactAccount.self)
    }
    
    func loadOneContactsList(userId: Int) -> Results<ContactAccount> {
        return AdaptationDBJSON().loadOneRecordFromDB(smTableDB: ContactAccount.self, filter: "uid == \(userId)")
    }
    
    func loadChatList() -> Results<Chat> {
        return AdaptationDBJSON().loadFromDB(smTableDB: Chat.self)
    }
    
    func loadChat(chatId: Int) -> Results<Chat> {
        return AdaptationDBJSON().loadOneRecordFromDB(smTableDB: Chat.self, filter: "id == \(chatId)")
    }
    
    func observerChatList(complition: @escaping (RealmCollectionChange<Results<Chat>>) -> Void) -> NotificationToken? {
        
        let smInfoFromDB = AdaptationDBJSON().loadFromDB(smTableDB: Chat.self)
        return AdaptationDBJSON().realmObserver(smTableDB: smInfoFromDB, complition: complition)
    }
    
    func loadMsgsFromChat(chatId: Int) -> [Message] {
        var msgs: [Message] = []
        if let chatFromDB = loadChat(chatId: chatId).first {
            msgs.append(contentsOf: chatFromDB.messages)
        }
        return msgs
    }
    
    func messageCounterZeroing(chatId: Int) {
        let chat = loadChat(chatId: chatId)
        if let chatElement = chat.first {
            let saveChat = Chat.init(
                id: chatElement.id,
                chatName: chatElement.chatName,
                messageCount: 0,
                messages: []
            )
            saveChat.messages.append(objectsIn: chatElement.messages)
            AdaptationDBJSON().saveInDB([saveChat])
        }
    }
    
    func saveMessages(isOpenChat: Int?, chatId: Int, chatName: String, message: Message) {
        let chat = loadChat(chatId: chatId)
        let saveChat = Chat.init(
            id: chatId,
            chatName: chatName,
            messageCount: 0,
            messages: []
        )
        if let chatElement = chat.first {
            saveChat.messageCount = chatElement.messageCount
            saveChat.messages.append(objectsIn: chatElement.messages)
        }
        if let id = isOpenChat {
            saveChat.messageCount = ( id == chatId ? 0 : saveChat.messageCount + 1)
        } else {
            saveChat.messageCount += 1
        }
        saveChat.messages.append(message)
        AdaptationDBJSON().saveInDB([saveChat])
    }
    
    func observerMessages(chatId: Int, complition: @escaping (RealmCollectionChange<Results<Chat>>, Int) -> Void) -> NotificationToken? {
        
        let smInfoFromDB = loadChat(chatId: chatId)
        return AdaptationDBJSON().realmObserver(smTableDB: smInfoFromDB) { complition($0, chatId) }
    }
}
