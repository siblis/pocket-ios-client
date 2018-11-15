//
//  ChatListTableViewController.swift
//  pocket-ios-client
//
//  Created by Damien on 08/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class ChatListTableViewController: UITableViewController {
    
    let cellReuseIdentifier = "ChatCell"
    
    var chatMessages: [ChatMessage]?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 100
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView(frame: .zero)
        //tableView.register(ChatListTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        setupData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let chatField = segue.destination as? ChatViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let indexChat = chatMessages?[indexPath.item]
            
            chatField?.chatName = indexChat?.friend?.name
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let count = chatMessages?.count {
           return count
        }
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ChatListTableViewCell
        cell.setup()
        
        if let chatMessage = chatMessages?[indexPath.item] {
            cell.nameLabel.text = chatMessage.friend?.name
            if let profileImageName = chatMessage.friend?.profileImageName{
                cell.profileImageView.image = UIImage(named: profileImageName)
            }
            cell.messageLabel.text = chatMessage.text
            cell.messageCountLabel.text = chatMessage.messageCount
            if let date = chatMessage.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                
                let elapsedTimeInSeconds = NSDate().timeIntervalSince(date as Date)
                let secondInDays: TimeInterval = 60 * 60 * 24
                
                if elapsedTimeInSeconds > 7 * secondInDays {
                    dateFormatter.dateFormat = "dd/MM/yy"
                }else if elapsedTimeInSeconds > secondInDays {
                    dateFormatter.dateFormat = "EEE"
                }
                
                cell.timeLabel.text = dateFormatter.string(from: date as Date)
            }
        }

        // Configure the cell...
//        cell.setup()

        return cell
    }
}
