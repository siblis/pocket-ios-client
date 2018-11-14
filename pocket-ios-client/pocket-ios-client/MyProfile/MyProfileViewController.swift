//
//  MyProfileViewController.swift
//  pocket-ios-client
//
//  Created by Anya on 12/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
    //определяем элементы экрана
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.98, green:0.98, blue:1.00, alpha:1.0)
        return view
    }()
    
    let editBtn:UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    let myPhoto: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = image.frame.size.width/2
        return image
    }()
    
    let myName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        label.textAlignment = .center
        return label
    }()
    
    let myEmail: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        label.textAlignment = .center
        return label
    }()
    
    let myId: UILabel = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTopView()
        setUpStatusView()
        
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
        
        
        MyProfileViewController.drawLine(startX: 0, endX: Int(screenWidth), startY: Int(safeAreaTopInset + 267), endY:  Int(safeAreaTopInset + 267), lineColor: UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0), lineWidth: 0.5, inView: backgroundView)
        
        backgroundView.addSubview(editBtn)
        backgroundView.addConstraintsWithFormat(format: "[v0(55)]-15-|", views: editBtn)
        backgroundView.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 12)-[v0(20)]", views: editBtn)
    }
    
    //настраиваем содержание элементов в верхней половине экрана
    func setUpTopViewContents () {
        editBtn.setTitle("Edit", for: .normal)

        myPhoto.image = UIImage(named: "myProfile")
        
        if (UserSelf.firstName + UserSelf.lastName).replacingOccurrences(of: " ", with: "") != "" {
            myName.text = UserSelf.lastName + " " + UserSelf.firstName
        } else {
            myName.text = UserSelf.account_name
        }
        
        myEmail.text = UserSelf.email
        myId.text = UserSelf.uid
        
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
        
        let screenWidth = UIScreen.main.bounds.width
        let tabBarWidth = self.tabBarController?.tabBar.frame.height
        let yPoint = UIScreen.main.bounds.height - tabBarWidth! - 74
        MyProfileViewController.drawLine(startX: 0, endX: Int(screenWidth), startY: Int(yPoint), endY: Int(yPoint), lineColor: UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0), lineWidth: 0.5, inView: self.view)
    }
    
    //настраиваем содержание элементов в нижней половине экрана
    func setUpStatusViewContents () {
        status.text = "Статус:"
        statusField.text = UserSelf.status
    }
    
    //рисуем горизонтальную линию
    static func drawLine(startX: Int, endX: Int, startY: Int, endY: Int, lineColor: UIColor, lineWidth: CGFloat, inView view: UIView) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: endX, y: endY))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        
        view.layer.addSublayer(shapeLayer)
    }
    
    @objc func editDetails(_ sender: UIButton) {
        performSegue(withIdentifier: "editDetailsSegue", sender: sender)
    }
}

