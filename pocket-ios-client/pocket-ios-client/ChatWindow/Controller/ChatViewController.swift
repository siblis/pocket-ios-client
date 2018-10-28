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
    
    //MARK: Init
    let insets: CGFloat = 5
    let cellReuseIdentifier = "MessageCell"
    var countMessage: Int = 0
    var dataMessage: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = self
        
        msgAndSocket.webSocketConnect()
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    @IBOutlet weak var message: UITextField! {
        didSet {
            message.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBAction func sendButton(_ sender: Any) {
        
        if let msg = message.text, msg != "" {
            msgAndSocket.sendMessage(receiver: 78, message: msg)
            self.countMessage += 1
            self.dataMessage = "\(78): \(msg)"
            self.tableView.reloadData()
            message.text = ""
        }
        
    }

    
    //MARK: Keyboard
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


extension ChatViewController: UITableViewDataSource {
    //MARK: Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countMessage
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ChatMessageCell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = self.dataMessage
        
        return cell
    }
}


extension ChatViewController {
    //MARK: Resizing elemets
    
    
}
