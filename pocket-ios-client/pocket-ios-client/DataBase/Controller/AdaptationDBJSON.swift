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
//    func editRecord<A: Object>(smTableDB: A.Type, smRecord: A, filter: String)
    func loadFromDB<A: Object>(smTableDB: A.Type) -> Results<A>
    func realmObserver<A: Object>(smTableDB: Results<A>, complition: @escaping (RealmCollectionChange<Results<A>>) -> Void) -> NotificationToken?
}

class AdaptationDBJSON: AdaptationInformation {
    
    let realm = try! Realm()
    
    func saveInDB(_ smElements: [Object]) {
        try! realm.write {
            realm.add(smElements, update: true)
        }
    }
    
    func editRecord<A: Object>(smTableDB: A.Type, smRecord: A, filter: String) {
        let smInfo = realm.objects(smTableDB.self).filter(filter)
        try! realm.write {
            realm.add(smRecord, update: true)
        }
    }
    
    func loadFromDB<A: Object>(smTableDB: A.Type) -> Results<A> {
       return realm.objects(smTableDB.self)
    }
    
    func loadOneRecordFromDB<A: Object>(smTableDB: A.Type, filter: String) -> Results<A> {
        return realm.objects(smTableDB.self).filter(filter)
    }
    
    func realmObserver<A: Object>(
        smTableDB: Results<A>,
        complition: @escaping (RealmCollectionChange<Results<A>>) -> Void
        ) -> NotificationToken? {
        
        return smTableDB.observe({ (changes) in
            complition(changes)
        })
    }
    
}
