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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SignUpButtonPress(_ sender: Any) {
        guard let account_name = loginTextField.text, let email = emailTextField.text, let password = passwordTextField.text else {return}
        guard !account_name.isEmpty, !email.isEmpty, !password.isEmpty else {
            print ("fill the data in fields")
            self.showErrorAlert(message: "Не все поля заполнены")
            return
        }
        
        User.account_name = account_name
        User.email = email
        User.password = password
        
        NetworkServices.signUp { (token, statusCode) in
            if (token != "") && (statusCode == 201) {
                User.token = token
                DispatchQueue.main.async {
                    let tabBarVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                    
                    self.present(tabBarVC, animated:true, completion:nil)
                }
            }
            else {
                if statusCode == 409 {
                    print ("user already exists")
                    DispatchQueue.main.async {
                        self.showErrorAlert(message: "Пользователь уже существует")
                    }
                } else if statusCode == 400 {                    print ("bad JSON")
                    DispatchQueue.main.async {
                        self.showErrorAlert(message: "Не все поля заполнены")
                    }
                } else {
                    print ("signUp error")
                    DispatchQueue.main.async {
                        self.showErrorAlert(message: "Ошибка соединения с сервером")
                    }
                }
                
            }
        }
    }
    
    //алерт с ошибкой
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
