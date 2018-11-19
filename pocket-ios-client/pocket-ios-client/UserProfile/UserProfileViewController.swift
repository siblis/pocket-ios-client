//
//  UserProfileViewController.swift
//  pocket-ios-client
//
//  Created by Anya on 16/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    let backButton:UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.layer.masksToBounds = true
        return button
    }()
    
    let deleteButton:UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.layer.masksToBounds = true
        return button
    }()
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.98, green:0.98, blue:1.00, alpha:1.0)
        return view
    }()

    
    let userPhoto: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 43
        image.layer.masksToBounds = true
        return image
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        label.textAlignment = .center
        return label
    }()
    
    let userEmail: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        label.textAlignment = .center
        return label
    }()
    
    let UserId: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        label.textAlignment = .center
        return label
    }()
    
    let chatPhoto: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = image.frame.size.width/2
        return image
    }()
    
    let chat: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.0)
        label.textAlignment = .center
        return label
    }()
    
    let status: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(red:0.55, green:0.55, blue:0.55, alpha:1.0)
        label.textAlignment = .left
        return label
    }()
    
    let statusField: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let safeAreaTopInset = UIApplication.shared.statusBarFrame.height
    let screenWidth = UIScreen.main.bounds.width
    
    var user: UserContact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        setUpTopView()
        setUpStatusView()
        
        backButton.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteUser(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpTopViewContents()
        setUpStatusViewContents()
    }
    
    
    //настраиваем положение элементов в верхней половине экрана
    func setUpTopView () {
        self.view.addSubview(backgroundView)
        self.view.addConstraintsWithFormat(format: "[v0(\(screenWidth))]", views: backgroundView)
        self.view.addConstraintsWithFormat(format: "V:|-0-[v0(\(safeAreaTopInset + 267))]", views: backgroundView)
        
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(deleteButton)
        self.view.addConstraintsWithFormat(format: "|-10-[v0(13)]-\(screenWidth-60)-[v1(22)]-15-|", views: backButton, deleteButton)
        self.view.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 12)-[v0(21)]", views: backButton)
        self.view.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 10)-[v0(24)]", views: deleteButton)
        
        backgroundView.addSubview(userPhoto)
        backgroundView.addConstraintsWithFormat(format: "[v0(86)]", views: userPhoto)
        userPhoto.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        backgroundView.addSubview(userName)
        backgroundView.addSubview(userEmail)
        backgroundView.addSubview(UserId)
        backgroundView.addSubview(chatPhoto)
        backgroundView.addSubview(chat)
        backgroundView.addConstraintsWithFormat(format: "|-30-[v0]-30-|", views: userName)
        backgroundView.addConstraintsWithFormat(format: "|-30-[v0]-30-|", views: userEmail)
        backgroundView.addConstraintsWithFormat(format: "|-30-[v0]-30-|", views: UserId)
        backgroundView.addConstraintsWithFormat(format: "[v0(38)]", views: chatPhoto)
        backgroundView.addConstraintsWithFormat(format: "|-30-[v0]-30-|", views: chat)
        chatPhoto.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        backgroundView.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 38)-[v0(86)]-7-[v1(20)]-2-[v2(15)]-3-[v3(15)]-10-[v4(38)]-6-[v5(12)]", views: userPhoto, userName, userEmail, UserId, chatPhoto, chat)
        
        
        MyProfileViewController.drawLine(startX: 0, endX: Int(screenWidth), startY: Int(safeAreaTopInset + 267), endY:  Int(safeAreaTopInset + 267), lineColor: UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0), lineWidth: 0.5, inView: backgroundView)
        
    }
    
    //настраиваем содержание элементов в верхней половине экрана
    func setUpTopViewContents () {
        backButton.setImage(UIImage(named: "back"), for: .normal)
        deleteButton.setImage(UIImage(named: "trash"), for: .normal)
        
        userPhoto.image = UIImage(named: user?.avatarImage ?? "noPhoto")
        
         if (user!.firstName + user!.lastName).replacingOccurrences(of: " ", with: "") != "" {
            userName.text = user!.lastName + " " + user!.firstName
        } else {
            userName.text = user!.account_name
        }
        
        userEmail.text = user!.email
        UserId.text = user!.id
        
        chatPhoto.image = UIImage(named: "chat")
        chat.text = "Chat"
    }
    
    //настраиваем положение элементов в нижней половине экрана
    func setUpStatusView () {
        self.view.addSubview(status)
        self.view.addSubview(statusField)
        
        self.view.addConstraintsWithFormat(format: "|-16-[v0(53)]", views: status)
        self.view.addConstraintsWithFormat(format: "|-16-[v0]-16-|", views: statusField)
        
        self.view.addConstraintsWithFormat(format: "V:|-0-[v0(\(safeAreaTopInset + 267))]-13-[v1(15)]-6-[v2]->=124-|", views: backgroundView, status, statusField)
        
    }
    
    //настраиваем содержание элементов в нижней половине экрана
    func setUpStatusViewContents () {
        status.text = "Статус:"
        statusField.text = user!.status
    }
    
    
    @objc func back (_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func deleteUser (_ sender: UIButton) {
        showDeleteAlert()
    }

    //алерт с удалением
    func showDeleteAlert() {
        let alert = UIAlertController(title: "", message: "Вы действительно хотите удалить пользователя?", preferredStyle: .alert)
        
        let actionYes = UIAlertAction(title: "Да", style: .default, handler: {(action: UIAlertAction) in
            let userContact = Contacts.list.firstIndex(where: {$0.id == self.user!.id})!
            Contacts.list.remove(at: userContact)
            
            let tabBarVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            
            self.present(tabBarVC, animated:true, completion:nil)
        })
        let actionNo = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        alert.addAction(actionYes)
        alert.addAction(actionNo)
        present(alert, animated: true, completion: nil)
    }
}
