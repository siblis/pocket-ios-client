//
//  UserListTableViewController.swift
//  pocket-ios-client
//
//  Created by Damien on 04/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit


class ContactListTableViewController: UITableViewController {
    
    var contactArray: [ContactAccount] = []// DataBase(.myData).loadContactsList()
//    var observerContactInDB: RealmNotification?
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
//        URLServices().getContacts(token: Account.token) { (contacts) in
//            DataBase(.myData).saveContacts(data: contacts)
//        }
//        observerContactInDB = DataBase(.myData).observerContacts() { (changes) in
//            if changes {
//                self.tableView.reloadData()
//            }
//        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        observerContactInDB = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.backPrimary
        tableView.rowHeight = SetupElementsUI().usrLstRowH
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
            chatField?.interlocutorID = contactArray[indexPath.row].uid
        }
    }
}
