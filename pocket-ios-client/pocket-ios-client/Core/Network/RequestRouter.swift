//
//  RequestRouter.swift
//  pocket-ios-client
//
//  Created by Мак on 01/11/2018.
//  Copyright © 2018 Мак. All rights reserved.
//

import Foundation

protocol RequestRouter {
    var sheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: String { get }
    var header: [String: String]? { get }
    var parameters: [String: String]? { get }
}

extension RequestRouter {
    var fullUrl: URL {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = sheme
        urlConstructor.host = host
        urlConstructor.path = path
        return urlConstructor.url!
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method
        urlRequest.allHTTPHeaderFields = header ?? [:]
        if parameters != nil {
            urlRequest.httpBody = try JSONEncoder().encode(parameters)
        }
        return urlRequest
    }
}
