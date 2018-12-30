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
    
    enum UploadVC {
        case login
        case tabbar
    }
    
    static func choiceRootVC() {
        if let token = TokenService.getToken(forKey: "token") {
            NetworkServices.getSelfUser(token: token) { (json, statusCode) in
                if statusCode == 200 {
                    DataBase().saveSelfUser(json: json)
                }
                else {
                    //На случай протухания токена
                    CorrectionMethods().autoLogIn()
                }
                DispatchQueue.main.async {
                    self.initVC(choiceVC: .tabbar)
                }
            }
        }
        else {
            initVC(choiceVC: .login)
        }
    }
    
    static func ifServerDown() {
        initVC(choiceVC: .tabbar)
    }
    
    static func initVC(choiceVC: UploadVC) {
        let initVC = UIStoryboard.init(name: "Login", bundle: nil)
        
        switch choiceVC {
        case .login:
            rootVC = initVC.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        case .tabbar:
            rootVC = initVC.instantiateViewController(withIdentifier: "TabBarController") as! InitAfterLogin            
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
}
