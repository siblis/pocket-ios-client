//
//  AlertFactory.swift
//  pocket-ios-client
//
//  Created by Мак on 18/02/2019.
//  Copyright © 2019 Damien Inc. All rights reserved.
//

import UIKit

struct ActionBtn {
    let name: String
    let style: UIAlertAction.Style
}

extension UIAlertController {
    
    enum AlertKind {
        case simple(title: String, message: String)
        case ifAlert(message: String, btns: [ActionBtn])
        case actionList(btns: [ActionBtn])
    }
    
    convenience init(show: AlertKind, completion: @escaping (String) -> Void?) {
        switch show {
        case .simple(let title, let message):
            self.init(title: title, message: message, preferredStyle: .alert)
            self.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        case .ifAlert(let message, let btns):
            self.init (title: "", message: message, preferredStyle: .alert)
            for btn in btns {
                self.addAction(UIAlertAction(title: btn.name, style: btn.style) { (doing) in
                    completion(btn.name)
                })
            }
        case .actionList(let btns):
            self.init (title: nil, message: nil, preferredStyle: .actionSheet)
            for btn in btns {
                self.addAction(UIAlertAction(title: btn.name, style: btn.style) { (doing) in
                    completion(btn.name)
                })
            }
        }
    }
}
