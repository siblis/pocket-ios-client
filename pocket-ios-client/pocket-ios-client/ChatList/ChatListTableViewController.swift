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

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 100
        tableView.alwaysBounceVertical = true
        tableView.register(ChatListTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ChatListTableViewCell

        // Configure the cell...
        cell.setup()

        return cell
    }

   
}
