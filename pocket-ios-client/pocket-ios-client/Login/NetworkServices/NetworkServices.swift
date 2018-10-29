//
//  LoginServices.swift
//  pocket-ios-client
//
//  Created by Damien on 02/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class NetworkServices {
    
    static func login(user: User, complition: @escaping (String) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pocketmsg.ru"
        urlComponents.path = "/v1/auth/"
        urlComponents.port = 8888
        
        guard let url = urlComponents.url else {fatalError("Could not create URL from components")}
        
        // PUT request
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        // JSON Encoder
        
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(user)
            request.httpBody = jsonData
            print("jsondata: ", String(data: request.httpBody!, encoding: .utf8) ?? "No body data")
        }
        catch {
            print (error.localizedDescription)
        }
        
        // Request и получение ответа от сервера
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, error) in
            guard error == nil else {
                print("Ошибка: \(error!)")
                complition("")
                return}
            
            if let data = responseData, let uft8Representation = String(data: data, encoding: .utf8) {
                print("Сообщение сервера: \(uft8Representation)")
                
                let stringSplit = uft8Representation.split(separator: "\"")
                complition(String(stringSplit[3]))
            }
            else {
                print ("Нет информации")
            }
        }
        task.resume()
    }
    
    static func getSelfUser(token: String, complition: @escaping (String) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pocketmsg.ru"
        urlComponents.path = "/v1/users/"
        urlComponents.port = 8888
        
        guard let url = urlComponents.url else {fatalError("Could not create URL from components")}
        
        //Далее GET руквест
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //Header
        
        var header = request.allHTTPHeaderFields ?? [:]
        header["token"] = token
        request.allHTTPHeaderFields = header
        
        //
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, error) in
            guard error == nil else {
                print("Ошибка: \(error!)")
                complition("Error")
                return
            }
            
            if let data = responseData, let uft8Representation = String(data: data, encoding: .utf8) {
                
                let stringSplit = uft8Representation.split(separator: "\"")
                complition(String(stringSplit[3]))
            }
            else {
                print ("Нет даты")
            }
        }
        task.resume()
        
    }
}
