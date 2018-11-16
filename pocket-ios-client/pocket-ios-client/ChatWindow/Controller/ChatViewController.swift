//
//  ChatViewController.swift
//  pocket-ios-client
//
//  Created by Мак on 18/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    
    //MARK: Init
    let insets: CGFloat = 15
    let cellReuseIdentifier = "MessageCell"
    var chatID: Int?
    var user: UserContact?
    var chatName: String?
    var chat: [Message] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = chatName
        setupData()
        //кнопка перехода на экран с деталями пользователя
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(infoButtonTap(_:)), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
        
        self.chatField.register(MessageCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        chatField.dataSource = self
        chatField.delegate = self
//        MessageAndWebSocket.webSocketConnect()
        for elemet in FakeData.testMessages {
            if Int(elemet.receiver) == chatID || elemet.senderid == chatID {
                chat.append(elemet)
            }
        }
    }
    
    @IBOutlet weak var chatField: UICollectionView! {
        didSet {
            
//            chatField.autoresizingMask = [.flexibleWidth, .flexibleHeight]
////            chatField.frame = self.view.frame
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
        
        if let msg = message.text, let chID = self.chatID, msg != "" {
            MessageAndWebSocket().sendMessage(receiver: chID, message: msg)
            self.chatField.reloadData()
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
    
    @objc func infoButtonTap (_ sender: UIButton) {
        performSegue(withIdentifier: "userDetailsSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userDetailsSegue" {
            let userDetailsVC = segue.destination as! UserProfileViewController
            if user != nil {
                userDetailsVC.user = self.user
            } else {
                userDetailsVC.user = UserContact()
                userDetailsVC.user?.account_name = chatName
                userDetailsVC.user?.avatarImage = "noPhoto"
            }
            
        }
    }
}



//MARK: Table
extension ChatViewController: UICollectionViewDataSource {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return chat.count
//            msgAndSocket.messageInOut.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! MessageCell
        
        let message = chat[indexPath.item]
        let messageText = message.text
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)] , context: nil)
            
        cell.messageTextView.text = message.text
        if message.isEnemy {
            cell.messageTextView.frame = CGRect(x:15 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRect(x:15 + 0, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
            cell.bubbleImageView.image = MessageCell.leftBubbleImage
            cell.bubbleImageView.tintColor = #colorLiteral(red: 0.8973206878, green: 0.9018508792, blue: 0.9191583991, alpha: 1)
            cell.messageTextView.textColor = UIColor.black
        } else {
            cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 16, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 8 - 16, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
            cell.bubbleImageView.image = MessageCell.rightBubbleImage
            cell.bubbleImageView.tintColor = #colorLiteral(red: 0.1881233156, green: 0.6438228488, blue: 0.9878250957, alpha: 1)
            cell.messageTextView.textColor = UIColor.white
        }
        
        return cell
    }
    

}
extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let messageText = chat[indexPath.item].text
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)] , context: nil)
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
//        }
//        
//        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
}

//MARK: Настройка положения элементов на вьюхе
extension ChatViewController {
    
    func setupElements(y: CGFloat) {
        
        sendBtnPosition(y: y)
        messagePosition(y: y)
        chatFieldPosition(y: y)
        
    }
    
    func chatFieldPosition(y: CGFloat) {
        
        let chatFieldWidth: CGFloat = UIScreen.main.bounds.size.width - insets
        let chatFieldHeight: CGFloat = UIScreen.main.bounds.size.height - sendBtn.frame.height - 4 * insets - y
        
        let xPosition: CGFloat = 0
        let yPosition: CGFloat = (self.navigationController?.navigationBar.intrinsicContentSize.height)!
        
        let chatFieldSize = CGSize(width: chatFieldWidth, height: chatFieldHeight)
        let chatFieldOrigin = CGPoint(x: xPosition, y: yPosition)
        
        chatField.frame = CGRect(origin: chatFieldOrigin, size: chatFieldSize)
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
