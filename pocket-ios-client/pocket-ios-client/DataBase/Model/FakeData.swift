//
//  FakeData.swift
//  pocket-ios-client
//
//  Created by Damien on 13/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

class FakeData {
    
    var user_1 = UserContact()
    var user_2 = UserContact()
    var user_3 = UserContact()
    var user_4 = UserContact()
    var user_5 = UserContact()
    
    init() {

        user_1.id = "21"
        user_1.account_name = "Владимир"
        user_1.email = ""
        user_1.status = "Убиваю"
        user_1.avatarImage = "man"
        
        user_2.id = "78"
        user_2.account_name = "Максим"
        user_2.email = ""
        user_2.status = "Прессую дизайнеров"
        user_2.avatarImage = "man"
        
        user_3.id = "157"
        user_3.account_name = "Аня"
        user_3.email = ""
        user_3.status = "Пишу код"
        user_3.avatarImage = "man"
        
        user_4.id = "158"
        user_4.account_name = "Юля"
        user_4.email = ""
        user_4.status = "Пишу код"
        user_4.avatarImage = "man"
        
        user_5.id = "0"
        user_5.account_name = "Steve Jobs"
        user_5.email = ""
        user_5.status = "Всё еще мёртвый"
        user_5.avatarImage = "steveprofile"
    }
    
    func fakeData(keyId: String) -> [UserContact] {
        switch keyId {
        case UserSelf.uid:
            return [user_1, user_2, user_3, user_4, user_5]
        default:
            return []
        }
    }
}
