//
//  ApplicationSwitcherRootController.swift
//  pocket-ios-client
//
//  Created by Damien on 09/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class ApplicationSwitcherRC {
    
    var rootVC: UIViewController!
    
    enum UploadVC {
        case login
        case tabbar
    }
    
    func choiceRootVC() {
        if let token = Token.main {
            URLServices().getContacts(token: token) { (contacts) in
                WSS.initial.webSocketConnect()
                DataBase().saveContacts(data: contacts)
                DispatchQueue.main.async {
                    self.initVC(choiceVC: .tabbar)
                }
            }
        }
        else {
            initVC(choiceVC: .login)
        }
    }
    
    func ifServerDown() {
        initVC(choiceVC: .tabbar)
    }
    
    func initVC(choiceVC: UploadVC) {
        let initVC = UIStoryboard.init(name: "Login", bundle: nil)
        
        switch choiceVC {
        case .login:
            rootVC = initVC.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        case .tabbar:
            rootVC = initVC.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
}
