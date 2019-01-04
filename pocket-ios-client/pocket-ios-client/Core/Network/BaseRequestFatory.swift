//
//  BaseRequestFactory.swift
//  StarShop
//
//  Created by Мак on 16/11/2018.
//  Copyright © 2018 Мак. All rights reserved.
//

import Foundation

class BaseRequestFatory: AbstractRequestFatory {
    
    let errorHandler: AbstractErrorHandler
    let errorParser: AbstractErrorParser
    let sessionManager: URLSession
    let queue: DispatchQueue?
    
    init(
        errorHandler: AbstractErrorHandler = ErrorHandler(),
        errorParser: AbstractErrorParser = ErrorParser(),
        sessionManager: URLSession = URLSession(configuration: URLSessionConfiguration.default),
        queue: DispatchQueue? = DispatchQueue.global()
        ) {
        
        self.errorHandler = errorHandler
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
    
    public func request<T: Decodable>(ask: URLRequest, completion: @escaping (T) -> Void) {
            return sessionManager
                .dataTask(with: ask) { [weak self] (responseData, response, error) in
                    guard let data = responseData, error == nil else {
                        print("Ошибка: \(error?.localizedDescription ?? "Error")")
                        return
                    }
                    do {
                        let resultInfo = try JSONDecoder().decode(T.self, from: data)
                        completion(resultInfo)
                    }
                    catch {
                        print(self?.errorParser.parse(error))
                    }
                    let httpResponse = response as? HTTPURLResponse
                    if let statusCode = httpResponse?.statusCode {
                        print(statusCode)
                    } else {
                        print (httpResponse!.allHeaderFields)
                    }
                }.resume()
    }
}
