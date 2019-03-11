//
//  CorrectionMethods.swift
//  pocket-ios-client
//
//  Created by Мак on 30/12/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation

class CorrectionMethods: ApplicationSwitcherRC {
    
    func autoLogIn() {
        let selfInfo = DataBase(.accounts).loadSelfUser()
        URLServices().signIn(login: selfInfo.accountName, password: selfInfo.password) { (info) in
            if info.token != "" {
                Account.token = info.token
                self.choiceRootVC()
            } else {
                self.logOut()
            }
        }
    }
    
    func sign(for personalInfo: SelfAccount) {
        DataBase(.accounts).saveSelfUser(info: personalInfo)
        DispatchQueue.main.async {
            ApplicationSwitcherRC().initVC(choiceVC: .tabbar)
        }
    }
    
    func logOut() {
        Account.token = ""
        ApplicationSwitcherRC().initVC(choiceVC: .login)
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
