//
//  CorrectionMethods.swift
//  pocket-ios-client
//
//  Created by Мак on 30/12/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

class CorrectionMethods {
    func autoLogIn() {
        let selfInfo = DataBase().loadSelfUser()
        URLServices().signIn(login: selfInfo.accountName, password: selfInfo.password) { (info) in
            if info.token != "" {
                Token.main = info.token
            } else {
                self.logOut()
            }
        }
    }
    
    func logOut() {
        Token.main = nil
        AdaptationDBJSON().deleteAllRecords()
        ApplicationSwitcherRC.initVC(choiceVC: .login)
    }
    
    func dateFormater(_ time: Double) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        let elapsedTimeInSeconds = NSDate().timeIntervalSince(date as Date)
        let secondInDays: TimeInterval = 60 * 60 * 24

        if elapsedTimeInSeconds > 7 * secondInDays {
            dateFormatter.dateFormat = "dd/MM/yy"
        }else if elapsedTimeInSeconds > secondInDays {
            dateFormatter.dateFormat = "EEE"
        }

        return dateFormatter.string(from: date as Date)
    }
}
