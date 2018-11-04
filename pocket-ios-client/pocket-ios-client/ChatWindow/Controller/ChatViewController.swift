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
    let insets: CGFloat = 15
    let cellReuseIdentifier = "MessageCell"
    var dataMessage = [String]()
    var userID: Int = 25

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
    
    @IBOutlet weak var sendBtn: UIButton! {
        didSet {
            sendBtn.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBAction func sendButton(_ sender: Any) {
        
        if let msg = message.text, msg != "" {
            msgAndSocket.sendMessage(receiver: self.userID, message: msg)
            self.dataMessage.append(msg)
            self.tableView.reloadData()
            message.text = ""
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupElements(y: 0)
        
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
        
        setupElements(y: value.cgRectValue.height)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        //Добавить возврат к обычному размеру чата
        setupElements(y: 0)
    }
}


extension ChatViewController: UITableViewDataSource {
    //MARK: Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ChatMessageCell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = "\(self.userID): \(self.dataMessage[indexPath.row])"
        
        return cell
    }
}


extension ChatViewController {
    //MARK: Resizing elemets
    
    func setupElements(y: CGFloat) {
        
        sendBtnPosition(y: y)
        messagePosition(y: y)
        tableViewPosition(y: y)
        
    }
    
    func tableViewPosition(y: CGFloat) {
        
        let tableViewWidth: CGFloat = UIScreen.main.bounds.size.width - insets
        let tableViewHeight: CGFloat = UIScreen.main.bounds.size.height - sendBtn.frame.height - 4 * insets - y
        
        let xPosition: CGFloat = 0
        let yPosition: CGFloat = (self.navigationController?.navigationBar.intrinsicContentSize.height)!
        
        let tableViewSize = CGSize(width: tableViewWidth, height: tableViewHeight)
        let tableViewOrigin = CGPoint(x: xPosition, y: yPosition)
        
        tableView.frame = CGRect(origin: tableViewOrigin, size: tableViewSize)
    }
    
    func messagePosition(y: CGFloat) {
        
        let messageWidth: CGFloat = UIScreen.main.bounds.size.width - sendBtn.frame.width - 3 * insets
        let messageHeight: CGFloat = 30
        
        let xPosition: CGFloat = insets
        let yPosition: CGFloat = UIScreen.main.bounds.size.height - messageHeight - insets - y
        
        let messageSize = CGSize(width: messageWidth, height: messageHeight)
        let messageOrigin = CGPoint(x: xPosition, y: yPosition)
        
        message.frame = CGRect(origin: messageOrigin, size: messageSize)
    }
    
    func sendBtnPosition(y: CGFloat) {
        
        let sendBtnWidth: CGFloat = 36
        let sendBtnHeight: CGFloat = 30
        
        let xPosition: CGFloat = UIScreen.main.bounds.size.width - sendBtnWidth - insets
        let yPosition: CGFloat = UIScreen.main.bounds.size.height - sendBtnHeight - insets - y
        
        let sendBtnSize = CGSize(width: sendBtnWidth, height: sendBtnHeight)
        let sendBtnOrigin = CGPoint(x: xPosition, y: yPosition)
        
        sendBtn.frame = CGRect(origin: sendBtnOrigin, size: sendBtnSize)
    }
}
