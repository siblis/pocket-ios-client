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
    
    enum LoadFile {
        case accounts
        case myData
    }
    
    let requestDB: AbstractRequestDB
    
    init(_ file: LoadFile) {
        var fileName: String
        var baseElements: [Object.Type]
        switch file {
        case .accounts:
            fileName = "accounts"
            baseElements = [MainAccounts.self]
        case .myData:
            fileName = Account.name
            baseElements = [Chat.self, ContactAccount.self, Group.self, Message.self]
        }
        self.requestDB = RequestDB(fileName: fileName, with: baseElements)
    }
    
    func deleteAllRecords() {
        requestDB.deleteAllRecords()
    }
    
    func deleteContactFromDB(_ contact: ContactAccount) {
        
        requestDB.deleteSomeRecords(smTableDB: Message.self, forKey: "receiver", keyValue: contact.uid)
        requestDB.deleteSomeRecords(smTableDB: Message.self, forKey: "senderid", keyValue: contact.uid)
        
        let contactCort: (smTableDB: Object.Type, forPrimaryKey: Int) = (Chat.self, contact.uid)
        let chatCort: (smTableDB: Object.Type, forPrimaryKey: Int) = (ContactAccount.self, contact.uid)
        let recordsToDelete: [(smTableDB: Object.Type, forPrimaryKey: Int)] = [contactCort, chatCort]
        
        requestDB.deleteSomeRecords(records: recordsToDelete)
    }
    
    //MARK: - Information about my profile
    func saveSelfUser(info: MainAccounts) {
        requestDB.saveInDB([info])
    }
    
    func loadSelfUser() -> MainAccounts {
        let selector = "accountName LIKE '\(Account.name)'"
        let myAccount = requestDB.loadOneRecordFromDB(smTableDB: MainAccounts.self, filter: selector)
        return myAccount[0]
    }
    
    //MARK: - My contacts
    func saveContacts(data: [ContactAccount]) {
        requestDB.saveInDB(data)
    }
    
    func observerContacts(complition: @escaping (Bool) -> Void) -> RealmNotification? {
        let smInfoFromDB = requestDB.loadFromDB(smTableDB: ContactAccount.self)
        return requestDB.realmObserver(for: smInfoFromDB, complition: complition)
    }
    
    func loadContactsList() -> Results<ContactAccount> {
        return requestDB.loadFromDB(smTableDB: ContactAccount.self)
    }
    
    func loadOneContactsList(userId: Int) -> Results<ContactAccount> {
        return requestDB.loadOneRecordFromDB(smTableDB: ContactAccount.self, filter: "uid == \(userId)")
    }
    
    //MARK: - Chat list
    func loadChatList() -> Results<Chat> {
        return requestDB.loadFromDB(smTableDB: Chat.self)
    }
    
    func loadChat(chatId: Int) -> Results<Chat> {
        return requestDB.loadOneRecordFromDB(smTableDB: Chat.self, filter: "id == \(chatId)")
    }
    
    func deleteChatFromDB(_ element: Chat) {
        requestDB.deleteSomeRecords(smTableDB: Message.self, forKey: "receiver", keyValue: element.id)
        requestDB.deleteSomeRecords(smTableDB: Message.self, forKey: "senderid", keyValue: element.id)
        requestDB.deleteOneRecord(smTableDB: Chat.self, forPrimaryKey: element.id)
    }
    
    func observerChatList(complition: @escaping (Bool) -> Void) -> RealmNotification? {
        let smInfoFromDB = requestDB.loadFromDB(smTableDB: Chat.self)
        return requestDB.realmObserver(for: smInfoFromDB, complition: complition)
    }
    
    //MARK: - Chat with messages
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
            requestDB.saveInDB([saveChat])
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
        requestDB.saveInDB([saveChat])
    }
    
    func observerMessages(chatId: Int, complition: @escaping (Bool, Int) -> Void) -> RealmNotification? {
        let chat = loadChat(chatId: chatId)
        return requestDB.realmObserver(for: chat) { complition($0, chatId) }
    }
}
