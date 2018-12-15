//
//  DataBase.swift
//  pocket-ios-client
//
//  Created by Damien on 13/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation
import RealmSwift

class DataBase {
    
    func saveSelfUser(json: Data) {
        do {
            let selfInfo = try JSONDecoder().decode(SelfAccount.self, from: json)
            AdaptationDBJSON().saveInDB([selfInfo])
        }
        catch let err {
            print("Err", err)
        }       
    }
    
    func loadSelfUser() -> SelfAccount {
        let smInfoFromDB = AdaptationDBJSON().loadFromDB(smTableDB: SelfAccount.self)
        return smInfoFromDB[0]
    }
    
    func observerSelfUser() -> NotificationToken? {
        let reload: Void = print("Load self data")
        let smInfoFromDB = AdaptationDBJSON().loadFromDB(smTableDB: SelfAccount.self)
        return AdaptationDBJSON().realmObserver(smTableDB: smInfoFromDB, someDoing: reload)
    }
    
    func saveContacts(json: Data) {
        do {
            let contactInfo = try JSONDecoder().decode(ContactAccount.self, from: json)
            AdaptationDBJSON().saveInDB([contactInfo])
        }
        catch let err {
            print("Err", err)
        }
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
    
    func saveMessages(message: [Chat], filter: String?) {
        if let fltr = filter, fltr != "" {
//           AdaptationDBJSON().editRecord(smTableDB: Chat.self, smRecord: message, filter: fltr)
        } else {
            AdaptationDBJSON().saveInDB(message)
        }
    }
}
