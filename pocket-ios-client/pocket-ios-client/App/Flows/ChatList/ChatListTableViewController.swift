//
//  ChatListTableViewController.swift
//  pocket-ios-client
//
//  Created by Damien on 08/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit
import RealmSwift

//MARK: - Класс отвечающий за список чатов с пользователями
class ChatListTableViewController: UITableViewController {
    
    //MARK: - Properties
    private let segueId = "SegueToChatFromChatList"
    private let cellReuseIdentifier = "ChatCell"
    var chatCell = DataBase().loadChatList()
    var observerChatList: NotificationToken?
    private var deleteRecord = UIButton() //right button is top bar
    private var editingRecords = UIButton()//left button is top bar
    private var isEnabledButton: Bool!

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        editingTableView()
        createBarButtonItem()
        isEnabledButton = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        observerChatListNSToken()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        observerChatList = nil
    }
    
    //MARK: - Methods
    private func createBarButtonItem() {
        
        //Left Bar Button Item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: editingRecords)
        self.editingRecords.setTitle("Edit", for: .normal)
        self.editingRecords.setTitleColor(UIColor.buttonPrimary, for: .normal)
        self.editingRecords.addTarget(self, action: #selector(clickEditingRecords(_:)), for: .touchUpInside)
        
        //Right Bar Button Item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: deleteRecord)
        self.deleteRecord.isHidden = true
        self.deleteRecord.setTitle("Delete", for: .normal)
        self.deleteRecord.setTitleColor(UIColor.red, for: .normal)
        self.deleteRecord.addTarget(self, action: #selector(clickDeleteRecord(_:)), for: .touchUpInside)
    }
    
    @objc func clickEditingRecords(_ sender: AnyObject) {
        isEnabledButton = !isEnabledButton
        if isEnabledButton == true {
            tableView.isEditing = !tableView.isEditing
            self.tableView.setEditing(true, animated: true)
            self.deleteRecord.isHidden = false
            print("Button is enabled true")
        } else {
            self.tableView.setEditing(false, animated: true)
            self.deleteRecord.isHidden = true
            print("Button is enabled false")
        }
    }
    
    @objc func clickDeleteRecord(_ sender: UIButton) {
        self.tableView.setEditing(false, animated: true)
        self.deleteRecord.isHidden = true
        self.isEnabledButton = false
    }
    
//    let indexPaths = self.tableView.indexPathsForSelectedRows
//    for indexPath in indexPaths! {
//    DataBase().deleteChatFromDB(self.chatCell[indexPath.row])
//    }

    
    private func editingTableView() {
        tableView.backgroundColor = UIColor.backPrimary
        tableView.rowHeight = SetupElementsUI().chatLstRowH
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func observerChatListNSToken() {
        observerChatList = DataBase().observerChatList() { (changes) in
            switch changes {
            case .initial, .update:
                self.chatCell = DataBase().loadChatList()
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEnabledButton == false {
            self.performSegue(withIdentifier: segueId, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let chatField = segue.destination as? ChatViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let user = DataBase().loadOneContactsList(userId: chatCell[indexPath.item].id)
            chatField?.chatInformation = user[0]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatCell.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ChatListTableViewCell
        cell.setup()
        
        
        
        let chatMessage = chatCell[indexPath.item]
        let user = DataBase().loadOneContactsList(userId: chatMessage.id)
        cell.nameLabel.text = user[0].accountName
        cell.profileImageView.image = UIImage(named: user[0].avatarImage)
        if let sender = chatMessage.messages.last?.senderName, let msg = chatMessage.messages.last?.text {
            cell.messageLabel.text = "\(sender): \(msg)"
        }
        cell.messageCountLabel.text = String(describing: chatMessage.messageCount)
        if let date = chatMessage.messages.last?.time {
            cell.timeLabel.text = CorrectionMethods().dateFormater(date)
        }
        
        return cell
    }
    
    //MARK: - Delete cell
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            DataBase().deleteChatFromDB(chatCell[indexPath.row])
//        }
//    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let shareAction = UITableViewRowAction(style: .default, title: "Editing") {
            _, indexPath in
            let alert = UIAlertController(title: "Options", message: "There will be functions", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { (sender: UIAlertAction) -> Void in
            })
            
            self.present(alert, animated: true, completion: nil)
        }
        
        shareAction.backgroundColor = UIColor.buttonPrimary
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {
            _, indexPath in
            DataBase().deleteChatFromDB(self.chatCell[indexPath.row])
        }
        
        return [deleteAction, shareAction]
    }

    //MARK: - Check out cell
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle(rawValue: 3)!
    }
}
