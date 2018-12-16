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

    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 100
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView(frame: .zero)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let chatField = segue.destination as? ChatViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let user = DataBase().loadOneContactsList(userId: chatCell[indexPath.item].id)
            chatField?.user = user[0]
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return chatCell.count //FakeData.chatMessages.count

    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ChatListTableViewCell
        cell.setup()
        
        let chatMessage = chatCell[indexPath.item]
        let user = DataBase().loadOneContactsList(userId: chatMessage.id)
        cell.nameLabel.text = user[0].accountName
        cell.profileImageView.image = UIImage(named: user[0].avatarImage)
        cell.messageLabel.text = chatMessage.messages.last?.text
        cell.messageCountLabel.text = String(describing: chatMessage.messageCount)
//        if let date = chatMessage.time {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "h:mm a"
//            
//            let elapsedTimeInSeconds = NSDate().timeIntervalSince(date as Date)
//            let secondInDays: TimeInterval = 60 * 60 * 24
//            
//            if elapsedTimeInSeconds > 7 * secondInDays {
//                dateFormatter.dateFormat = "dd/MM/yy"
//            }else if elapsedTimeInSeconds > secondInDays {
//                dateFormatter.dateFormat = "EEE"
//            }
//            
//            cell.timeLabel.text = dateFormatter.string(from: date as Date)
//        }
        cell.timeLabel.text = chatMessage.messages.last?.time
        return cell
    }
}
