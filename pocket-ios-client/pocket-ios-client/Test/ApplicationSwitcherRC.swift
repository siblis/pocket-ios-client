//
//  ApplicationSwitcherRootController.swift
//  pocket-ios-client
//
//  Created by Damien on 09/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class ApplicationSwitcherRC {
    
    static var rootVC: UIViewController!
    
    enum ChoiceRootVC {
        case login
        case tabbar
    }
    
    static func choiseRootVC() {
        
        let token = TokenService.getToken(forKey: "token")
        print (User.account_name + " " + User.email + " " + User.password)
        
        if token != nil {
            NetworkServices.getSelfUser(token: token!) { (json, statusCode) in
                
                if statusCode == 200 {
                    
                    DataBase.saveSelfUser(json: json)
                    DataBase.instance.loadAllContactsFromDB(keyId: User.uid)
                    
                    DispatchQueue.main.async {
                        choiceVC(choiseVC: .tabbar)
                    }
                }
                else {
                    //Костыль на случай протухания токена
                    TokenService.setToken(token: nil, forKey: "token")
                    DispatchQueue.main.async {
                        choiceVC(choiseVC: .login)
                    }
                }
            }
        }

        else {
            choiceVC(choiseVC: .login)
        }
    }
    
    static func ifServerDown() {
        
        choiceVC(choiseVC: .tabbar)
        
    }
    
    static func choiceVC(choiseVC: ChoiceRootVC) {
        let initVC = UIStoryboard.init(name: "Login", bundle: nil)
        
        switch choiseVC {
        case .login:
            rootVC = initVC.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        case .tabbar:
            rootVC = initVC.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
}
