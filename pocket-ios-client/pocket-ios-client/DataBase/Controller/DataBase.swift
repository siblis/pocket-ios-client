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
    
    func saveContacts(json: Data) {
//        do {
//            let contactInfo = try JSONDecoder().decode([ContactAccount].self, from: json)
//            AdaptationDBJSON().saveInDB(contactInfo)
//        }
//        catch let err {
//            print("Err", err)
//        }
        let selfInfo = loadSelfUser()
        var contactsArray: Array<ContactAccount> = []
        do {
            let data = try JSONSerialization.jsonObject(with: json, options: JSONSerialization.ReadingOptions()) as! [String: [String: Any]]
            for i in data {
                let contacts = loadContactsList()
                var check: Int = 0
                for j in contacts { check = i.key == j.email ? check + 1 : check + 0 }
                if i.key != selfInfo.email && check == 0 {
                    let contact = ContactAccount.init(
                        uid: i.value["id"] as! Int,
                        accountName: i.value["name"] as! String,
                        email: i.key
                    )
                    AdaptationDBJSON().saveInDB([contact])
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func observerContacts(complition: @escaping (RealmCollectionChange<Results<ContactAccount>>) -> Void) -> NotificationToken? {
        
        let smInfoFromDB = AdaptationDBJSON().loadFromDB(smTableDB: ContactAccount.self)
        return AdaptationDBJSON().realmObserver(smTableDB: smInfoFromDB) { (changes) in
            complition(changes)
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
