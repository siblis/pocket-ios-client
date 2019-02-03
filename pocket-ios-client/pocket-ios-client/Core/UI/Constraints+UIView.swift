//
//  Constraints+UIView.swift
//  pocket-ios-client
//
//  Created by Мак on 20/01/2019.
//  Copyright © 2019 Damien Inc. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
