//
//  LoginServices.swift
//  pocket-ios-client
//
//  Created by Damien on 02/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class NetworkServices {
    
    //Получаем пользователя по никнейму
    static func getUserByNickname(nickname: String, token: String, complition: @escaping (Data, Int) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pocketmsg.ru"
        urlComponents.path = "/v1/users/" + nickname
        urlComponents.port = 8888
        
        guard let url = urlComponents.url else {fatalError("Could not create URL from components")}
        
        //Далее GET реквест
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //Header
        var header = request.allHTTPHeaderFields ?? [:]
        header["token"] = token
        request.allHTTPHeaderFields = header
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, error) in
            guard let data = responseData, error == nil else {
                print("Ошибка: \(error?.localizedDescription ?? "Error")")
                return
            }
            let httpResponse = response as? HTTPURLResponse
            if let statusCode = httpResponse?.statusCode, statusCode == 200 {
                print ("statusCode = \(statusCode)")
                complition(data, statusCode)
            } else {
                print (httpResponse!.allHeaderFields)
                complition(data, 0)
            }
        }
        task.resume()
    }
}
