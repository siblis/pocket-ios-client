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
    
    static var response: String!
    
    static func choiseRootVC() {
        
        let token = TokenService.getToken(forKey: "token")
        
        if token != nil {
            NetworkServices.getSelfUser(token: token!) { (response, statusCode) in
                self.response = response
                
                if statusCode == 200 {
                    DispatchQueue.main.async {
                        rootVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = rootVC
                    }
                } else {
                    DispatchQueue.main.async {
                         rootVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
//                        rootVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = rootVC
                    }
                }
            }
            
        }

        else {
            rootVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = rootVC
        }
    }
}
