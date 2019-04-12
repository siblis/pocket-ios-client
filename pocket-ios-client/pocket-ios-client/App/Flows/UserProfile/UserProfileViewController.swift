//
//  UserProfileViewController.swift
//  pocket-ios-client
//
//  Created by Anya on 16/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit


class UserProfileViewController: UIViewController {
    
    private let btnForAlert: [ActionBtn] = [
        ActionBtn.init(name: "Да", style: .default),
        ActionBtn.init(name: "Нет", style: .cancel)
    ]

    let backButton = Interface().btnIni()
    let addDeleteButton = Interface().btnIni()
    let backgroundView = Interface().viewIni(color: UIColor.backPrimary)
    let userPhoto = Interface().imgIni(radius: 43)
    let chatPhoto = Interface().imgRoundIni()
    let UserId = Interface().lblIni(font: UIFont.usrProfId, textColor: UIColor.textPrimary, textAlignment: .center)
    let status = Interface().lblIni(font: UIFont.usrProfStat, textColor: UIColor.textSecondary, textAlignment: .left)
    
    let userName = Interface().lblIni(
        font: UIFont.usrProfName,
        textColor: UIColor.textPrimary,
        textAlignment: .center
    )
    
    let userEmail = Interface().lblIni(
        font: UIFont.usrProfEmail,
        textColor: UIColor.textPrimary,
        textAlignment: .center
    )
    
    let chat = Interface().lblIni(
        font: UIFont.usrProfChat,
        textColor: UIColor.buttonSecondary,
        textAlignment: .center
    )
    
    let statusField = Interface().lblIni(
        font: UIFont.usrProfStFld,
        textColor: UIColor.textSecondary,
        textAlignment: .left
    )
    
    let safeAreaTopInset = UIApplication.shared.statusBarFrame.height
    let screenWidth = UIScreen.main.bounds.width
    
    var user = ContactAccount()
    let myGroup = DispatchGroup()
    var isContact = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        setUpTopView()
        setUpStatusView()
        
        backButton.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
        addDeleteButton.addTarget(self, action: #selector(addDeleteBtnTap(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myGroup.enter()
        let contactArray = DataBase(.myData).loadContactsList()
        print("load contacts")
        myGroup.leave()
        if contactArray.contains(where: {$0.uid == user.uid}) {
            isContact = true
        } else {
            isContact = false
        }
        setUpTopViewContents()
        setUpStatusViewContents()
    }
    
    
    //настраиваем положение элементов в верхней половине экрана
    func setUpTopView () {
        self.view.addSubview(backgroundView)
        self.view.addConstraintsWithFormat(format: "[v0(\(screenWidth))]", views: backgroundView)
        self.view.addConstraintsWithFormat(format: "V:|-0-[v0(\(safeAreaTopInset + 267))]", views: backgroundView)
        
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(addDeleteButton)
        self.view.addConstraintsWithFormat(format: "|-10-[v0(13)]-\(screenWidth-60)-[v1(22)]-15-|", views: backButton, addDeleteButton)
        self.view.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 12)-[v0(21)]", views: backButton)
        self.view.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 10)-[v0(24)]", views: addDeleteButton)
        
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
        
        
        Interface().drawLine(startX: 0, endX: Int(screenWidth), startY: Int(safeAreaTopInset + 267), endY:  Int(safeAreaTopInset + 267), lineColor: UIColor.line, lineWidth: 0.5, inView: backgroundView)
        
    }
    
    //настраиваем содержание элементов в верхней половине экрана
    func setUpTopViewContents () {
        backButton.setImage(UIImage(named: "back"), for: .normal)
        if isContact {
            addDeleteButton.setImage(UIImage(named: "trash"), for: .normal)
            print ("trash")
        } else {
            addDeleteButton.setImage(UIImage(named: "add"), for: .normal)
            print ("add")
        }
        
        userPhoto.image = UIImage(named: user.avatarImage)
        userName.text = user.accountName
        userEmail.text = user.email
        UserId.text = String(describing: user.uid)
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
        statusField.text = ""
    }
    
    
    @objc func back (_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addDeleteBtnTap (_ sender: UIButton) {
        if isContact {
            showDeleteAlert()
        } else {
//            if !Account.token.isEmpty {
//                URLServices().addUserByMail(user.email, token: Account.token) { (contact) in
//                    print ("success")
//                }
//            }
//            DataBase(.myData).saveContacts(data: [user])
            showAddAlert()
        }
    }

    //алерт с удалением
    func showDeleteAlert() {
        let message: String = "Вы действительно хотите удалить пользователя?"
        let alert = UIAlertController(show: .ifAlert(message: message, btns: btnForAlert)) { (btnAction) in
            switch btnAction {
            case "Да":
//                if !Account.token.isEmpty {
//                    URLServices().deleteUserByMail(self.user.email, token: Account.token) { (contact) in
//                        print("success: \(contact)")
//                    }
//                }
//                
//                DataBase(.myData).deleteContactFromDB(self.user)
                
                self.dismiss(animated: true, completion: nil)
                
                return nil
            default:
                return nil
            }
        }
        present(alert, animated: true, completion: nil)
    }
    
    //алерт с добавлением
    func showAddAlert () {
        let action = UIAlertController(show: .simple(title: "Пользователь добавлен", message: "")) {_ in
            return nil
        }
        present(action, animated: true, completion: nil)
    }
}
