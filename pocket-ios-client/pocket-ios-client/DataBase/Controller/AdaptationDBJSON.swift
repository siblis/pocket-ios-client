//
//  AdaptationDBJSON.swift
//  pocket-ios-client
//
//  Created by Мак on 05/12/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation
import RealmSwift

protocol AdaptationInformation {
    func saveInDB(_ smElements: [Object])
}

class AdaptationDBJSON: AdaptationInformation {
    
    func saveInDB(_ smElements: [Object]) {
        DispatchQueue.global().async {
            let realm = try! Realm()
            try! realm.write {
                realm.add(smElements, update: true)
            }
        }
    }
    
}
