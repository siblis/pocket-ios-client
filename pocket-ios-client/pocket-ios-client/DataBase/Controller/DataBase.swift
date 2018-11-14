//
//  DataBase.swift
//  pocket-ios-client
//
//  Created by Damien on 13/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

class DataBase {
    
    static let instance = {
        return DataBase()
    }()
    
    private init() {}
    
    func test() {}

    static func saveSelfUser(json: [String: Any]) {
    
    User.uid = "\(json["uid"] ?? 0)"
    User.account_name = "\(json["account_name"] ?? "")"
    User.email = "\(json["email"] ?? "")"
        
}
    
    private func addContact(userContact: UserContact) {
        Contacts.list.append(userContact)
    }
    
    private func removeContact(userContact: UserContact) {
        var i = 0
        Contacts.list.forEach { (user) in
            if user.id == userContact.id {
                Contacts.list.remove(at: i)
            }
            i+=1
        }
    }
    
    private func loadAllContacts(userContact: [UserContact]) {
        for contact in userContact {
            addContact(userContact: contact)
        }
    }
    
    func loadAllContactsFromDB(keyId: Any) {
        
        let key = keyId as! String
        
        loadAllContacts(userContact: FakeData().fakeData(keyId: key))
    }
    
    func addContactToDB(userContact: UserContact) {
        addContact(userContact: userContact)
    }
    
    func removeContactToDB(userContact: UserContact) {
        removeContact(userContact: userContact)
    }
}
