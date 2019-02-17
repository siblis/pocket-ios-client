//
//  MyProfileViewController.swift
//  pocket-ios-client
//
//  Created by Anya on 12/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit


class MyProfileViewController: UIViewController {
    
    var selfInfo = DataBase(.accounts).loadSelfUser()
    
    //определяем элементы экрана
    let backgroundView = Interface().viewIni(color: UIColor.backSecondary)
    let editBtn = Interface().btnIni(textAlignment: .left)
    let logOutBtn = Interface().btnIni(textAlignment: .right)
    let myPhoto = Interface().imgIni(radius: 43)
    let chatPhoto = Interface().imgRoundIni()
    let myName = Interface().lblIni(font: UIFont.myProfName, textColor: UIColor.textPrimary, textAlignment: .center)
    let myId = Interface().lblIni(font: UIFont.myProfId, textColor: UIColor.textPrimary, textAlignment: .center)
    let status = Interface().lblIni(font: UIFont.myProfStat, textColor: UIColor.textSecondary, textAlignment: .left)
    
    let myEmail = Interface().lblIni(
        font: UIFont.myProfEmail,
        textColor: UIColor.textPrimary,
        textAlignment: .center
    )
    
    let chat = Interface().lblIni(
        font: UIFont.myProfChat,
        textColor: UIColor.buttonSecondary,
        textAlignment: .center
    )
    
    let statusField = Interface().lblIni(
        font: UIFont.myProfStFld,
        textColor: UIColor.backPrimary,
        textAlignment: .left
    )
    
    let safeAreaTopInset = UIApplication.shared.statusBarFrame.height
    let screenWidth = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTopView()
        setUpStatusView()
        
        logOutBtn.addTarget(self, action: #selector(self.accountLogOut(_:)), for: .touchUpInside)
        editBtn.addTarget(self, action: #selector(self.editDetails(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpTopViewContents()
        setUpStatusViewContents()
    }
    
    
    //настраиваем положение элементов в верхней половине экрана
    func setUpTopView () {
        self.view.addSubview(backgroundView)
        self.view.addConstraintsWithFormat(format: "|-0-[v0]-0-|", views: backgroundView)
        self.view.addConstraintsWithFormat(format: "V:|-0-[v0(\(safeAreaTopInset + 267))]", views: backgroundView)
        
        backgroundView.addSubview(myPhoto)
        backgroundView.addConstraintsWithFormat(format: "[v0(86)]", views: myPhoto)
        myPhoto.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        backgroundView.addSubview(myName)
        backgroundView.addSubview(myEmail)
        backgroundView.addSubview(myId)
        backgroundView.addSubview(chatPhoto)
        backgroundView.addSubview(chat)
        backgroundView.addConstraintsWithFormat(format: "|-30-[v0]-30-|", views: myName)
        backgroundView.addConstraintsWithFormat(format: "|-30-[v0]-30-|", views: myEmail)
        backgroundView.addConstraintsWithFormat(format: "|-30-[v0]-30-|", views: myId)
        backgroundView.addConstraintsWithFormat(format: "[v0(38)]", views: chatPhoto)
        backgroundView.addConstraintsWithFormat(format: "|-30-[v0]-30-|", views: chat)
        chatPhoto.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        backgroundView.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 38)-[v0(86)]-7-[v1(20)]-2-[v2(15)]-3-[v3(15)]-10-[v4(38)]-6-[v5(12)]", views: myPhoto, myName, myEmail, myId, chatPhoto, chat)
        
        
        Interface().drawLine(startX: 0, endX: Int(screenWidth), startY: Int(safeAreaTopInset + 267), endY:  Int(safeAreaTopInset + 267), lineColor: UIColor.line, lineWidth: 0.5, inView: backgroundView)
        
        backgroundView.addSubview(editBtn)
        backgroundView.addSubview(logOutBtn)
        backgroundView.addConstraintsWithFormat(format: "|-3-[v0(55)]", views: editBtn)
        backgroundView.addConstraintsWithFormat(format: "[v0(55)]-3-|", views: logOutBtn)
        backgroundView.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 13)-[v0(20)]", views: editBtn)
        backgroundView.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 13)-[v0(20)]", views: logOutBtn)
    }
    
    //настраиваем содержание элементов в верхней половине экрана
    func setUpTopViewContents () {
        editBtn.setTitle("Edit", for: .normal)
        logOutBtn.setTitle("Exit", for: .normal)

        myPhoto.image = UIImage(named: "myProfile")
        
        if (selfInfo.firstName + selfInfo.lastName).replacingOccurrences(of: " ", with: "") != "" {
            myName.text = selfInfo.lastName + " " + selfInfo.firstName
        } else {
            myName.text = selfInfo.accountName
        }
        
        myEmail.text = selfInfo.email
        myId.text = String(describing: selfInfo.uid)
        
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
        statusField.text = selfInfo.status
    }
    
    @objc func editDetails(_ sender: UIButton) {
        performSegue(withIdentifier: "editDetailsSegue", sender: sender)
    }
    
    @objc func accountLogOut(_ sender: UIButton) {
        CorrectionMethods().logOut()
    }
}

