//
//  SignUpViewController.swift
//  pocket-ios-client
//
//  Created by Anya on 01/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!

    var user: User!
    var token: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUpButtonPress(_ sender: Any) {
        guard let account_name = loginTextField.text, let email = emailTextField.text, let password = passwordTextField.text else {return}
        guard !account_name.isEmpty, !email.isEmpty, !password.isEmpty else {
            print ("fill the data in fields")
            return
        }

        user = User(account_name: account_name, email: email, password: password)
        
        NetworkServices.signUp(user: user) { (token) in
            if token != "" {
                UserDefaults.standard.set(token, forKey: "token")
                self.token = token
            }
            else {
                self.token = ""
                print ("signUp error")
            }
        }
        
        if token != "" {
            let tabBarVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            
            present(tabBarVC, animated:true, completion:nil)
        }
    }
    

}
