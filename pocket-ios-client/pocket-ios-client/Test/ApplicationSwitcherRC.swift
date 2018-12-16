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
        if token != nil {
            initVC(choiseVC: .tabbar)
        }
        else {
            initVC(choiseVC: .login)
        }
    }
    
    static func ifServerDown() {
        initVC(choiseVC: .tabbar)
    }
    
    static func initVC(choiseVC: ChoiceRootVC) {
        let initVC = UIStoryboard.init(name: "Login", bundle: nil)
        
        switch choiseVC {
        case .login:
            rootVC = initVC.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        case .tabbar:
            rootVC = initVC.instantiateViewController(withIdentifier: "TabBarController") as! InitAfterLogin            
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
}
