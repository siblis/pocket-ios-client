//
//  AdaptationDBJSON.swift
//  pocket-ios-client
//
//  Created by Мак on 05/12/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit
import RealmSwift

protocol AdaptationInformation {
    func saveInDB(_ smElements: [Object])
}

class AdaptationDBJSON: AdaptationInformation {
    
    let realm = try! Realm()
    
    func saveInDB(_ smElements: [Object]) {
        try! self.realm.write {
                self.realm.add(smElements, update: true)
        }
    }
    
    func loadFromDB<A: Object>(smTableDB: A.Type) -> Results<A> {
       return self.realm.objects(smTableDB.self)
    }
    
    
    func realmObserver<A: Object>(smTableDB: Results<A>) -> NotificationToken? {
        return smTableDB.observe({ (changes) in
            switch changes {
            case .initial, .update:
                print("Some doing")
            case .error(let error):
                print(error)
            }
        })
    }
    
}
