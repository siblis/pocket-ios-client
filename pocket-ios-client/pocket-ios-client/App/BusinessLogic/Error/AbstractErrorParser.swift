//
//  AbstractErrorParser.swift
//  pocket-ios-client
//
//  Created by Мак on 01/11/2018.
//  Copyright © 2018 Мак. All rights reserved.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, error: Error?) -> Error?
}

enum AppError: Error {
    
    case serverError(String)
    case badToken(String)
    case undefinedError(String)
    
    var description: String {
        switch self {
        case .serverError(let description):
            return description
        case .badToken(let description):
            return description
        case .undefinedError(let description):
            return description
        }
    }
}

class ErrorParser: AbstractErrorParser {
    
    func parse(_ result: Error) -> Error {
        if result is DecodingError {
            return AppError.serverError("Server error")
        }
        return AppError.undefinedError("Undefined error")
    }
    
    func parse(response: HTTPURLResponse?, error: Error?) -> Error? {
        if let err = error {
            return AppError.undefinedError(err.localizedDescription)
        } else {
            switch response?.statusCode {
            case 401:
                return AppError.badToken("Bad token. 401")
            default:
                return AppError.undefinedError("Undefined error")
            }
        }
    }
}
