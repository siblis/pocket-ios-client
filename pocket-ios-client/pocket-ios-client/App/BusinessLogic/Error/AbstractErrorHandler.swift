//
//  AbstractErrorHandler.swift
//  StarShop
//
//  Created by Мак on 02/11/2018.
//  Copyright © 2018 Мак. All rights reserved.
//

import Foundation

protocol AbstractErrorHandler {
    func handle (error: Error?)
}


final class ErrorHandler: AbstractErrorHandler {
    
    func handle(error: Error?) {
        switch error as! AppError {
        case .badToken:
            DispatchQueue.main.async {
                CorrectionMethods().autoLogIn()
            }
        default:
            print(error)
        }
    }
}
