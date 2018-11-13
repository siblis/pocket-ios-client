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
}
