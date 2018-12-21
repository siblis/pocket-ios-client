//
//  SignUpViewController.swift
//  pocket-ios-client
//
//  Created by Anya on 01/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit
import RealmSwift

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var user = User()
    var selfInfo = SelfAccount()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    @IBAction func SignUpButtonPress(_ sender: Any) {
        guard let accountName = loginTextField.text, let email = emailTextField.text, let password = passwordTextField.text else {return}
        guard !accountName.isEmpty, !email.isEmpty, !password.isEmpty else {
            print ("fill the data in fields")
            self.showErrorAlert(message: "Не все поля заполнены")
            return
        }
        
        selfInfo.accountName = accountName
        selfInfo.email = email
        selfInfo.password = password
        
        NetworkServices.signUp(accountName: accountName, email: email, password: password) { (json, statusCode) in
            if statusCode == 201 {
                do {
                    let signUpInfo = try JSONDecoder().decode(SignUpResponse.self, from: json)
                    Token.token = signUpInfo.token
                    self.selfInfo.uid = signUpInfo.uid
                    AdaptationDBJSON().saveInDB([self.selfInfo])
                }
                catch let err {
                    print("Err", err)
                }
                DispatchQueue.main.async {
                    ApplicationSwitcherRC.initVC(choiseVC: .tabbar)
                }
            } else {
                self.showErrorAlert(message: String(describing: statusCode))
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
    
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
}
