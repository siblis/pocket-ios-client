//
//  ChatViewController.swift
//  pocket-ios-client
//
//  Created by Мак on 18/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    let msgAndSocket = MessageAndWebSocket()
    
    let insets: CGFloat = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        msgAndSocket.webSocketConnect()
    }
    
    @IBOutlet weak var message: UITextField! {
        didSet {
            message.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBAction func sendBotton(_ sender: Any) {
        
        if let msg = message.text, msg != "" {
            msgAndSocket.sendMessage(receiver: 24, message: msg)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    //MARK: Keyboard show&hide
    @objc func keyboardWillShow(notification: Notification) {
        guard let info = notification.userInfo as? NSDictionary, let value = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else { return }
        
        //Добавить уменьшение вьюхи с чатом
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        //Добавить возврат к обычному размеру чата
        
    }
}

extension ChatViewController {
    //MARK: Resizing elemets
}
