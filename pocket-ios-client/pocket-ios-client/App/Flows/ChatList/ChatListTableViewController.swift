//
//  ChatListTableViewController.swift
//  pocket-ios-client
//
//  Created by Damien on 08/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit
import RealmSwift

class ChatListTableViewController: UITableViewController {
    
    let cellReuseIdentifier = "ChatCell"
    var chatCell = DataBase().loadChatList()
    var observerChatList: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.backgroundColor = UIColor.backPrimary
        tableView.rowHeight = SetupElementsUI().chatLstRowH
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        observerChatList = nil
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataBase().deleteChatFromDB(chatCell[indexPath.row])
        }
    }
}
