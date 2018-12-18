//
//  AddUserController.swift
//  pocket-ios-client
//
//  Created by Юлия Чащина on 24/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AddUserController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2071147859, green: 0.5941259265, blue: 0.8571158051, alpha: 1)
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        collectionView.alwaysBounceVertical = true
        title = "Новый контакт"

        // Register cell classes
        self.collectionView!.register(AddUserCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        addButton.addTarget(self, action: #selector(self.addContact(_:)), for: .touchUpInside)
        setupViews()
    }
    
    @objc func addContact(_ sender: UIButton) {
//        let cell = AddUserCell.identifi
//        let someMail =
//        if let token = TokenService.getToken(forKey: "token") {
//            NetworkServices.addUserByMail(someMail, token: token) { (json, statusCode) in
//                if statusCode == 201 {
//                    DataBase().saveContacts(json: json)
//                }
//                else {
//                    print("Error: \(statusCode)")
//                }
//            }
//        } else {
//            print("Token is empty")
//        }
    }
    
    func setupViews() {
        
        view.addSubview(addButton)
        let centralXConstraint = NSLayoutConstraint(item: addButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centralYConstraint = NSLayoutConstraint(item: addButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -100)
        view.addConstraint(centralXConstraint)
        view.addConstraint(centralYConstraint)
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
}

