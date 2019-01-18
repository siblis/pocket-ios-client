//
//  AbstractErrorHandler.swift
//  StarShop
//
//  Created by Мак on 02/11/2018.
//  Copyright © 2018 Мак. All rights reserved.
//

import Foundation

protocol AbstractErrorHandler {
    func handle (error: AppError)
}


final class ErrorHandler: AbstractErrorHandler {
    func handle(error: AppError) {
        switch error {
        case .badToken:
            CorrectionMethods().autoLogIn()
        default:
            print(error)
        }
    }
}
