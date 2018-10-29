//
//  ViewController.swift
//  pocket-ios-client
//
//  Created by Damien on 12.08.2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginLable: UILabel!
    @IBOutlet weak var passwordLable: UILabel!
    @IBOutlet weak var pocketLable: UILabel!
    @IBOutlet weak var messangerLable: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var singUpButton: UIButton!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var user: User!
    var token: String!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        guard let account_name = loginTextField.text, let password = passwordTextField.text else {return}
        
        user = User(account_name: account_name, password: password)
        
        NetworkServices.login(user: user) { (token) in
            if token != "" {
               UserDefaults.standard.set(token, forKey: "token")
               self.token = token
            }
            else {
                self.token = ""
                print ("Error Login")
            }
        }
        
        // Грязный хак пока выполняется паралельный запрос
        // Такое себе, но пока не знаю как иначе сделать
        // Но работает :)
        while token == nil {}
        /////////
        
        if token != "" {
            performSegue(withIdentifier: "UserListSegue", sender: nil)}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if segue.identifier == "UserListSegue" {
//            let destination: UserListTableViewController = segue.destination as! UserListTableViewController
//        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        
    }


}

