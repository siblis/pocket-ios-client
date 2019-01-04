//
//  AbstractErrorParser.swift
//  StarShop
//
//  Created by Мак on 01/11/2018.
//  Copyright © 2018 Мак. All rights reserved.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}

enum AppError: Error {
    case serverError
    case undefinedError
}

class ErrorParser: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        if result is DecodingError {
            return AppError.serverError
        }
        return AppError.undefinedError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return AppError.undefinedError
    }
}
