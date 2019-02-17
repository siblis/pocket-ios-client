//
//  AddUserController.swift
//  pocket-ios-client
//
//  Created by Anya on 24/12/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit


class AddUserController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var users: [ContactAccount] = []
    var groups: [GroupInfo] = []
    var selectedGroup = Group()
    let sectionTitles = ["Участники", "Группы"]
    let myGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.layer.borderColor = UIColor.backSearchBar.cgColor
        searchBar.layer.borderWidth = 1

        tableView.rowHeight = 50
        self.tabBarController?.tabBar.isHidden = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return users.count
        case 1:
            return groups.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
            
            cell.setUp()
            cell.configure(user: users[indexPath.row])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupCell
            
            cell.setUp()
            cell.configure(group: groups[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if users.count == 0 {
                return 0
            } else {
                return 30
            }
        case 1:
            if groups.count == 0 {
                return 0
            } else {
                return 30
            }
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            performSegue(withIdentifier: "showSelectedUserDetails", sender: self)
        case 1:
            selectedGroup = Group.init(
                gid: groups[indexPath.row].gid,
                groupName: groups[indexPath.row].groupName,
                users: [ContactAccount]()
            )
            
            if !Account.token.isEmpty {
                for id in groups[indexPath.row].users {
                    myGroup.enter()
                    URLServices().getUserID(id: Int(id), token: Account.token) { (contact) in
                        self.selectedGroup.users.append(contact)
                        print ("add contact")
                        self.myGroup.leave()
                    }
                }
                myGroup.notify(queue: .main) {
                    self.performSegue(withIdentifier: "showSelectedGroupDetails", sender: self)
                }
            }
        default:
            print ("default")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        users.removeAll()
        groups.removeAll()
        let searchText = searchBar.text!
        let digitSet = CharacterSet.decimalDigits
        
        if !Account.token.isEmpty {
            if searchText.contains("@") {
                print ("Searching by email...")
                URLServices().getUserByEmail(email: searchText, token: Account.token) { (contact) in
                    self.users.append(contact)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } else if digitSet.contains(searchText.unicodeScalars.first!) {
                print ("Searching by id...")
                if let id = Int(searchText) {
                    URLServices().getUserID(id: id, token: Account.token) { (contact) in
                        self.users.append(contact)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } else {
                print ("Searching by nickname...")
                NetworkServices.getUserByNickname(nickname: searchText, token: Account.token) { (data, statusCode) in
                    if statusCode == 200 {
//                        print (JSON(data))
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String: [String:String]]
                            for element in json {
                                let user = ContactAccount(uid: Int(element.key) ?? 0, accountName: element.value["account_name"] ?? "", email: element.value["email"] ?? "")
                                self.users.append(user)
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    else {
                        print ("Status code: \(statusCode)")
                    }

                    print ("users: \(self.users)")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            
            print ("Searching group")
            URLServices().getGroupInfo(info: searchText, token: Account.token) { (group) in
                self.groups.append(group)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSelectedUserDetails" {
            let userDetails = segue.destination as? UserProfileViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                userDetails!.user = users[indexPath.row]
            }
        }
        else if segue.identifier == "showSelectedGroupDetails" {
            let groupDetails = segue.destination as? GroupProfileViewController
            groupDetails!.group = selectedGroup
        }
    }

}
