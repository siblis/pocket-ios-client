//
//  EditProfileViewController.swift
//  pocket-ios-client
//
//  Created by Anya on 13/11/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    //определяем элементы экрана
    let cancelBtn:UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    let doneBtn:UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    let editLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        label.textAlignment = .center
        return label
    }()
    
    let myPhoto: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = image.frame.size.width/2
        return image
    }()
    
    let firstName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.returnKeyType = .done
        return textField
    }()
    
    let lastName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Фамилия"
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.returnKeyType = .done
        return textField
    }()
    
    let status: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Статус:"
        textField.returnKeyType = .done
        return textField
    }()

    let safeAreaTopInset = UIApplication.shared.statusBarFrame.height
    let screenWidth = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpHeader()
        setUpHeaderContents()
        setUpBody()
        setUpBodyContents()
        
        cancelBtn.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)

    }
    
    func setUpHeader () {
        self.view.addSubview(cancelBtn)
        self.view.addSubview(doneBtn)
        self.view.addSubview(editLabel)
        
        self.view.addConstraintsWithFormat(format: "|-15-[v0(55)]-[v1(150)]-[v2(55)]-15-|", views: cancelBtn, editLabel, doneBtn)
        editLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.view.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 12)-[v0(20)]", views: cancelBtn)
        self.view.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 12)-[v0(20)]", views: editLabel)
        self.view.addConstraintsWithFormat(format: "V:|-\(safeAreaTopInset + 12)-[v0(20)]", views: doneBtn)
        
    }
    
    func setUpHeaderContents () {
        cancelBtn.setTitle("Cancel", for: .normal)
        editLabel.text = "Редактирование"
        doneBtn.setTitle("Done", for: .normal)
    }
    
    func setUpBody () {
        self.view.addSubview(myPhoto)
        self.view.addSubview(firstName)
        self.view.addSubview(lastName)
        self.view.addSubview(status)
        
        self.view.addConstraintsWithFormat(format: "|-28-[v0(67)]", views: myPhoto)
        self.view.addConstraintsWithFormat(format: "V:[v0]-39-[v1(67)]", views: cancelBtn, myPhoto)
        self.view.addConstraintsWithFormat(format: "[v0]-25-[v1]-15-|", views: myPhoto, firstName)
        self.view.addConstraintsWithFormat(format: "[v0]-25-[v1]-15-|", views: myPhoto, lastName)
        self.view.addConstraintsWithFormat(format: "|-37-[v0]-15-|", views: status)
        self.view.addConstraintsWithFormat(format: "V:[v0]-44-[v1(20)]-15-[v2(20)]-36-[v3(20)]", views: editLabel, firstName, lastName, status)
        
        MyProfileViewController.drawLine(startX: (28+67+17), endX: Int(screenWidth-14), startY: Int(safeAreaTopInset + 102), endY: Int(safeAreaTopInset + 102), lineColor: UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0), lineWidth: 1, inView: self.view)
        MyProfileViewController.drawLine(startX: (28+67+17), endX: Int(screenWidth-14), startY: Int(safeAreaTopInset + 137), endY: Int(safeAreaTopInset + 137), lineColor: UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0), lineWidth: 1, inView: self.view)
        MyProfileViewController.drawLine(startX: 29, endX: Int(screenWidth-14), startY: Int(safeAreaTopInset + 193), endY: Int(safeAreaTopInset + 193), lineColor: UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0), lineWidth: 1, inView: self.view)
    }
    
    func setUpBodyContents () {
        myPhoto.image = UIImage(named: "noPhoto")
    }
    
    @objc func cancel (_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
