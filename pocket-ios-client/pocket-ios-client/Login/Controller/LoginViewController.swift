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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        guard let password = passwordTextField.text, let account_name = loginTextField.text else {return}
        
        User.password = password
        User.account_name = account_name
        
        NetworkServices.login() { (token) in
            if token != "" {
                User.token = token
                NetworkServices.getSelfUser(token: token) { (response, statusCode) in
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
                    } else {
                        print ("GetSelfUser error")
                    }
                }
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "UserListSegue", sender: nil)
                }
            }
            else {
                print ("Error Login")
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        let signUpVC = UIStoryboard.init(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        present(signUpVC, animated:true, completion:nil)
    }
}

