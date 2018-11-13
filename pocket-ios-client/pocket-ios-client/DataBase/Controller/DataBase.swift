//
//  DataBase.swift
//  pocket-ios-client
//
//  Created by Damien on 13/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

class DataBase {

    static func saveSelfUser(json: [String: Any]) {
    
    User.uid = "\(json["uid"] ?? 0)"
    User.account_name = "\(json["account_name"] ?? "")"
    User.email = "\(json["email"] ?? "")"
        
}
    
    static func addContact(userContact: UserContact) {
        
        Contacts.list.append(userContact)
        
    }
    
    static private func loadAllContacts(userContact: [UserContact]) {
        
        for contact in userContact {
            DataBase.addContact(userContact: contact)
        }
        
    }
    
    static func loadAllContactsFromDB(keyId: Any) {
        
        let key = keyId as! String
        
        loadAllContacts(userContact: FakeData().fakeData(keyId: key))
    }
}
