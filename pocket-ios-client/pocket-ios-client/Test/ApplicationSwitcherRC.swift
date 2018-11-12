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
        print (User.account_name + " " + User.email + " " + User.password)
        
        if token != nil {
            NetworkServices.getSelfUser(token: token!) { (response, statusCode) in
                self.response = response
                
                if statusCode == 200 {
                    var json: [String: Any] = [:]
                    do {
                        let data = response.data(using: .utf8)
                        json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as! [String: Any]
                        User.uid = "\(json["uid"] ?? 0)"
                        User.account_name = "\(json["account_name"] ?? "")"
                        User.email = "\(json["email"] ?? "")"
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    DispatchQueue.main.async {
                        rootVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = rootVC
                    }
                } else {
                    DispatchQueue.main.async {
                        //rootVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        rootVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
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
    
    static func ifServerDown() {
        
        rootVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
}
