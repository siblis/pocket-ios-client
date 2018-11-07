//
//  LoginServices.swift
//  pocket-ios-client
//
//  Created by Damien on 02/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit

class NetworkServices {
    
    //функция регистрации пользователей
    static func signUp(user: User, complition: @escaping (String, Int) -> Void) {
        
        //POST request
        let url = URL(string: "https://pocketmsg.ru:8888/v1/users/")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        
        // делаем JSON
        let headers = ["account_name":user.account_name,"email":user.email,"password":user.password]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: headers)
            print("jsondata: ", String(data: request.httpBody!, encoding: .utf8) ?? "No body data")
        }
        catch {
            print (error.localizedDescription)
        }
        
        // Request и получение ответа от сервера
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: request) { (responseData, response, error) in
            guard let data = responseData, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            let httpResponse = response as? HTTPURLResponse
            if httpResponse != nil {
                let statusCode = httpResponse!.statusCode
                print (statusCode)
                
                //проверяем статус ответа
                if statusCode == 201 {
                    var json: [String: String] = [:]
                    do {
                        json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String: String]
                        print ("token = \(json["token"] ?? "")")
                        print (json)
                        complition(json["token"] ?? "", statusCode)
                    } catch {
                        print(error.localizedDescription)
                        complition("", statusCode)
                    }
                } else if statusCode == 409 {
                    print ("user is already registered")
                    complition("", statusCode)
                } else if statusCode == 400 {
                    print ("bad JSON")
                    complition("", statusCode)
                } else {
                    print ("unknown error, status code = \(statusCode)")
                    complition("", statusCode)
                }
            } else {
                print (httpResponse!.allHeaderFields)
            }
        }
        task.resume()
    }
    
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
                
                var json: [String: String] = [:]
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String: String]
                    print ("token = \(json["token"] ?? "")")
                    complition(json["token"] ?? "")
                } catch {
                    print(error.localizedDescription)
                    complition("")
                }
            }
            else {
                print ("Нет информации")
            }
        }
        task.resume()
    }
    
    static func getSelfUser(token: String, complition: @escaping (String, Int) -> Void) {
        
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
            guard let data = responseData, error == nil else {
                print("Ошибка: \(error?.localizedDescription)")
                complition((error?.localizedDescription)!, 0)
                return
            }
            
            let httpResponse = response as? HTTPURLResponse
            let uft8Representation = String(data: data, encoding: .utf8) ?? "Нет даты"
            print("Data print: \(uft8Representation)")
            
            if httpResponse != nil {
                let statusCode = httpResponse!.statusCode
                print ("statusCode = \(statusCode)")
                
                complition(uft8Representation, statusCode)
            } else {
                print (httpResponse!.allHeaderFields)
                complition(uft8Representation, 0)
            }
            
        }
        task.resume()
        
    }
}
