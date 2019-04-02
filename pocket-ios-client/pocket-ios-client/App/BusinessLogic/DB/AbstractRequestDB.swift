//
//  AbstractRequestDB.swift
//  pocket-ios-client
//
//  Created by Мак on 05/12/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit
import RealmSwift

typealias RealmNotification = NotificationToken

protocol AbstractRequestDB: class {
    func saveInDB(_ smElements: [Object])
    func deleteAllRecords()
    func deleteDBFile()
    func deleteOneRecord<A: Object>(smTableDB: A.Type, forPrimaryKey: Int)
    func deleteSomeRecords<A: Object>(smTableDB: A.Type, forKey: String, keyValue: Int)
    func deleteSomeRecords<A: Object>(records: [(smTableDB: A.Type, forPrimaryKey: Int)])
    func loadFromDB<A: Object>(smTableDB: A.Type) -> Results<A>
    func loadOneRecordFromDB<A: Object>(smTableDB: A.Type, filter: String) -> Results<A>
    func realmObserver<A: Object>(for smRecordsDB: Results<A>, complition: @escaping (Bool) -> Void) -> NotificationToken?
}

class RequestDB: AbstractRequestDB {
    
    private let realm: Realm
    
    init(fileName: String, with baseElements: [Object.Type]) {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(fileName).realm")
        config.objectTypes = baseElements
        config.schemaVersion = shemaDB
        self.realm = try! Realm(configuration: config)
    }
    
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
    
    func deleteDBFile() {
//        let folderPath = realm.configuration.fileURL!.deletingLastPathComponent().path
//
//        // Disable file protection for this directory
//        try! FileManager.default.setAttributes(<#[FileAttributeKey : Any]#>, ofItemAtPath: folderPath)
    }
    
    func deleteOneRecord<A: Object>(smTableDB: A.Type, forPrimaryKey: Int) {
        realm.beginWrite()
        if let smElement = realm.object(ofType: smTableDB.self, forPrimaryKey: forPrimaryKey) {
            realm.delete(smElement)
        }
        do {
            try realm.commitWrite()
            print ("realm delete")
        }
        catch {
            print (error.localizedDescription)
        }
    }
    
    func deleteSomeRecords<A: Object>(smTableDB: A.Type, forKey: String, keyValue: Int){
        
        realm.beginWrite()
        
        let elements = realm.objects(smTableDB.self).filter(forKey + " = \(keyValue)")
        
        realm.delete(elements)
        do {
            try realm.commitWrite()
            print ("realm delete")
        }
        catch {
            print (error.localizedDescription)
        }
        
    }
    
    func deleteSomeRecords<A: Object>(records: [(smTableDB: A.Type, forPrimaryKey: Int)]) {
        realm.beginWrite()
        for record in records{
            
            if let smElement = realm.object(ofType: record.smTableDB.self, forPrimaryKey: record.forPrimaryKey){
                realm.delete(smElement)
            }
        }
        
        do {
            try realm.commitWrite()
            print ("realm delete")
        }
        catch {
            print (error.localizedDescription)
        }
    }
    
    func loadFromDB<A: Object>(smTableDB: A.Type) -> Results<A> {
       return realm.objects(smTableDB.self)
    }
    
    func loadOneRecordFromDB<A: Object>(smTableDB: A.Type, filter: String) -> Results<A> {
        let oneRecordFromDB = realm.objects(smTableDB.self).filter(filter)
        return oneRecordFromDB
    }
    
    func realmObserver<A: Object>(
        for smRecordsDB: Results<A>,
        complition: @escaping (Bool) -> Void
        ) -> NotificationToken? {
        
        return smRecordsDB.observe() { (changes) in
            switch changes {
            case .initial, .update:
                complition(true)
            case .error(let error):
                print(error)
                complition(false)
            }
        }
    }
    
}
