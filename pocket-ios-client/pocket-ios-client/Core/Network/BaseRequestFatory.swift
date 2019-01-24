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
                .dataTask(with: ask) { (responseData, response, error) in
                    guard let data = responseData, error == nil else {
                        print("Ошибка: \(error?.localizedDescription ?? "Error")")
                        return
                    }
                    if let err = self.errorParser.parse(response: response as? HTTPURLResponse, error: error) {
                        self.errorHandler.handle(error: err)
                    }
                    
                    do {
                        let resultInfo = try JSONDecoder().decode(T.self, from: data)
                        completion(resultInfo)
                    }
                    catch let errDecod{
                        print(self.errorParser.parse(errDecod))
                    }
                }.resume()
    }
}
