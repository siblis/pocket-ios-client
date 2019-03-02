//
//  AbstractRequestFactory.swift
//  StarShop
//
//  Created by Мак on 01/11/2018.
//  Copyright © 2018 Мак. All rights reserved.
//

import Foundation

protocol AbstractRequestFatory: class {
    var errorParser: AbstractErrorParser { get }
    var errorHandler: AbstractErrorHandler { get }
    var sessionManager: URLSession { get }
    var queue: DispatchQueue? { get }
    
    func request<T: Decodable>(ask: URLRequest, completion: @escaping (T) -> Void)
}
