//
//  UserListTableViewController.swift
//  pocket-ios-client
//
//  Created by Damien on 04/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {
    
    let contactArray = DataBase().loadContactsList()
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 60
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView(frame: .zero)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return contactArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactListTableViewCell
        
        cell.setUp()

        cell.nameLabel.text = contactArray[indexPath.row].accountName
        cell.profileImageView.image = UIImage(named: contactArray[indexPath.row].avatarImage)
        cell.statusLabel.text = ""

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let chatField = segue.destination as? ChatViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            chatField?.user = contactArray[indexPath.row]
        }
    }
}
