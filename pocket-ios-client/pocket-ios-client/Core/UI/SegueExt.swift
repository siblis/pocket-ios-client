//
//  SegueExt.swift
//  pocket-ios-client
//
//  Created by Мак on 21/03/2019.
//  Copyright © 2019 Damien Inc. All rights reserved.
//

//import UIKit
//
//class Box {
//    let value: Any
//    init(_ value: Any) {
//        self.value = value
//    }
//}
//
//extension UIViewController {
//    struct AssociatedKey {
//        static var ClosurePrepareForSegueKey = "ClosurePrepareForSegueKey"
//        static var token: dispatch_once_t = 0
//    }
//    
//    typealias ConfiguratePerformSegue = (UIStoryboardSegue) -> ()
//    
//    func performSegueWithIdentifier(identifier: String, sender: AnyObject?, configurate: ConfiguratePerformSegue?) {
//        swizzlingPrepareForSegue()
//        configuratePerformSegue = configurate
//        performSegue(withIdentifier: identifier, sender: sender)
//    }
//    
//    private func swizzlingPrepareForSegue() {
//        dispatch_once(&AssociatedKey.token) {
//            let originalSelector = #selector(UIViewController.prepareForSegue(_:sender:))
//            let swizzledSelector = #selector(UIViewController.closurePrepareForSegue(_:sender:))
//            
//            let instanceClass = UIViewController.self
//            let originalMethod = class_getInstanceMethod(instanceClass, originalSelector)
//            let swizzledMethod = class_getInstanceMethod(instanceClass, swizzledSelector)
//            
//            let didAddMethod = class_addMethod(instanceClass, originalSelector,
//                                               method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
//            
//            if didAddMethod {
//                class_replaceMethod(instanceClass, swizzledSelector,
//                                    method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
//            } else {
//                method_exchangeImplementations(originalMethod, swizzledMethod)
//            }
//        }
//    }
//    
//    func closurePrepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        configuratePerformSegue?(segue)
//        closurePrepareForSegue(segue: segue, sender: sender)
//        configuratePerformSegue = nil
//    }
//    
//    var configuratePerformSegue: ConfiguratePerformSegue? {
//        get {
//            let box = objc_getAssociatedObject(self, &AssociatedKey.ClosurePrepareForSegueKey) as? Box
//            return box?.value as? ConfiguratePerformSegue
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKey.ClosurePrepareForSegueKey, Box(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//        }
//    }
//}
