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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 1

        tableView.rowHeight = 50
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell

        cell.setUp()
        cell.configure(user: users[indexPath.row])

        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        users.removeAll()
        let searchText = searchBar.text!
        let digitSet = CharacterSet.decimalDigits
        
        if let token = TokenService.getToken(forKey: "token") {
            print(token)
            if searchText.contains("@") {
                print ("Searching by email...")
                NetworkServices.getUserByEmail(email: searchText, token: token) { (data, statusCode) in
                    if statusCode == 200 {
                        do {
                            let user = try JSONDecoder().decode(ContactAccount.self, from: data)
                            print (user)
                            self.users.append(user)
                        }
                        catch {
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
            } else if digitSet.contains(searchText.unicodeScalars.first!) {
                print ("Searching by id...")
                if let id = Int(searchText) {
                    NetworkServices.getUser(id: id, token: token) { (data, statusCode) in
                        if statusCode == 200 {
                            do {
                                let user = try JSONDecoder().decode(ContactAccount.self, from: data)
                                print (user)
                                self.users.append(user)
                            }
                            catch {
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
                
            } else {
                print ("Searching by nickname...")
                NetworkServices.getUserByNickname(nickname: searchText, token: token) { (data, statusCode) in
                    if statusCode == 200 {
//                        print (JSON(data))
                        var json: [String: [String:String]] = [:]
                        do {
                            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String: [String:String]]
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
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSelectedUserDetails" {
            let userDetails = segue.destination as? UserProfileViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                userDetails!.user = users[indexPath.row]
            }
        }
    }

}
