//
//  GroupProfileViewController.swift
//  pocket-ios-client
//
//  Created by Anya on 17/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class GroupProfileViewController: UIViewController {

    let backButton:UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.layer.masksToBounds = true
        return button
    }()
    
    let exitButton:UIButton = {
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
    
    
    let groupPhoto: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 43
        image.layer.masksToBounds = true
        return image
    }()
    
    let groupName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        label.textAlignment = .center
        return label
    }()
    
    let groupId: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        label.textAlignment = .center
        return label
    }()
    
    let participantsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.0)
        label.textAlignment = .center
        return label
    }()
    
    var group = Group()
    
    @IBOutlet weak var participantsTableView: UITableView!
    
    let safeAreaTopInset = UIApplication.shared.statusBarFrame.height
    let screenWidth = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        participantsTableView.delegate = self
        participantsTableView.dataSource = self
    
        setUpTopView()
        backButton.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitGroup(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTopViewContents()
    }
    
    //настраиваем положение элементов в верхней половине экрана
    func setUpTopView () {
        self.view.addSubview(backgroundView)
        self.view.addConstraintsWithFormat(format: "[v0(\(screenWidth))]", views: backgroundView)
        self.view.addConstraintsWithFormat(format: "V:|-0-[v0(\(safeAreaTopInset + 176))]", views: backgroundView)
        
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(exitButton)
        self.view.addConstraintsWithFormat(format: "|-10-[v0(13)]-\(screenWidth-62)-[v1(24)]-15-|", views: backButton, exitButton)
        self.view.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 12)-[v0(21)]", views: backButton)
        self.view.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 10)-[v0(24)]", views: exitButton)
        
        backgroundView.addSubview(groupPhoto)
        backgroundView.addConstraintsWithFormat(format: "[v0(86)]", views: groupPhoto)
        groupPhoto.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        backgroundView.addSubview(groupName)
        backgroundView.addSubview(groupId)
        backgroundView.addConstraintsWithFormat(format: "|-30-[v0]-30-|", views: groupName)
        backgroundView.addConstraintsWithFormat(format: "|-30-[v0]-30-|", views: groupId)
        
        MyProfileViewController.drawLine(startX: 0, endX: Int(screenWidth), startY: Int(safeAreaTopInset + 176), endY:  Int(safeAreaTopInset + 176), lineColor: UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0), lineWidth: 0.5, inView: backgroundView)
        
        backgroundView.addSubview(participantsLabel)
        backgroundView.addConstraintsWithFormat(format: "|-30-[v0]-30-|", views: participantsLabel)
        backgroundView.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 38)-[v0(86)]-7-[v1(20)]-3-[v2(15)]-19-[v3(24)]", views: groupPhoto, groupName, groupId, participantsLabel)
        
        MyProfileViewController.drawLine(startX: 0, endX: Int(screenWidth), startY: Int(safeAreaTopInset + 227), endY:  Int(safeAreaTopInset + 227), lineColor: UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0), lineWidth: 0.5, inView: backgroundView)
        
    }
    
    //настраиваем содержание элементов в верхней половине экрана
    func setUpTopViewContents () {
        backButton.setImage(UIImage(named: "back"), for: .normal)
        exitButton.setImage(UIImage(named: "exit"), for: .normal)
        
        groupPhoto.image = UIImage(named: "noPhoto")
        
        groupName.text = group.groupName
        groupId.text = String(describing: group.gid)
        
        participantsLabel.text = "Участники"
    }
    
    @objc func back (_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func exitGroup (_ sender: UIButton) {
        
    }
}

extension GroupProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "participantCell", for: indexPath) as! ParticipantCell
        let user = group.users[indexPath.row]
        let name = user.accountName

        cell.setUp()
        cell.setUpContents(name: "\(name)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGroupContactDetails" {
            let destination = segue.destination as! UserProfileViewController
            if let row = participantsTableView.indexPathForSelectedRow?.row {
                let user = group.users[row]
                destination.user = user
            }
        }
    }
}
