//
//  ViewController.swift
//  pocket-ios-client
//
//  Created by Damien on 12.08.2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
   
    @IBOutlet weak var pocketLable: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var singUpButton: UIButton!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Email",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        guard let password = passwordTextField.text, let email = loginTextField.text else { return }
        URLServices().signIn(login: email, password: password) { (info) in
            if !info.token.isEmpty {
                Account.token = info.token
                Account.name = email
                let user = MainAccounts()
                user.id = info.user.id
                user.nick = info.user.profile?.userName ?? ""
                user.email = email
                user.password = password
                CorrectionMethods().sign(for: user)
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        let signUpVC = UIStoryboard.init(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        present(signUpVC, animated:true, completion:nil)
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

