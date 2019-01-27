//
//  AbstractRequestDB.swift
//  pocket-ios-client
//
//  Created by Мак on 05/12/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit
import RealmSwift

protocol AbstractRequestDB: class {
    func saveInDB(_ smElements: [Object])
    func deleteAllRecords()
    func deleteOneRecord<A: Object>(smTableDB: A.Type, forPrimaryKey: Int)
    func loadFromDB<A: Object>(smTableDB: A.Type) -> Results<A>
    func loadOneRecordFromDB<A: Object>(smTableDB: A.Type, filter: String) -> Results<A>
    func realmObserver<A: Object>(smTableDB: Results<A>, complition: @escaping (RealmCollectionChange<Results<A>>) -> Void) -> NotificationToken?
}

class RequestDB: AbstractRequestDB {
    
    let realm = try! Realm()
    
    func saveInDB(_ smElements: [Object]) {
        try! realm.write {
            realm.add(smElements, update: true)
        }
    }
    
    func deleteAllRecords() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func deleteOneRecord<A: Object>(smTableDB: A.Type, forPrimaryKey: Int) {
        realm.beginWrite()
        if let smElement = realm.object(ofType: smTableDB.self, forPrimaryKey: forPrimaryKey) {
            realm.delete(smElement)
            do {
                try realm.commitWrite()
                print ("realm delete")
            }
            catch {
                print (error.localizedDescription)
            }
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
