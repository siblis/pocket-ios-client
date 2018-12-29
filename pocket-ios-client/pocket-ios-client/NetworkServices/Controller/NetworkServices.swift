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
    static func signUp(accountName: String, email: String, password: String, complition: @escaping (Data, Int) -> Void) {
        
        //POST request
        let url = URL(string: "https://pocketmsg.ru:8888/v1/auth/register/")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        // делаем JSON
        let httpBody = ["account_name": accountName, "email": email, "password": password]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: httpBody)
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
                complition(data, statusCode)
            } else {
                print (httpResponse!.allHeaderFields)
            }
        }
        task.resume()
    }
    
    static func login(accountName: String, password: String, complition: @escaping (String) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pocketmsg.ru"
        urlComponents.path = "/v1/auth/login/"
        urlComponents.port = 8888
        
        guard let url = urlComponents.url else {fatalError("Could not create URL from components")}
        
        // PUT request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // JSON Encoder
        let httpBody = ["account_name": accountName, "password": password]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: httpBody)
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
    
    static func getSelfUser(token: String, complition: @escaping (Data, Int) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pocketmsg.ru"
        urlComponents.path = "/v1/account/"
        urlComponents.port = 8888
        
        guard let url = urlComponents.url else {fatalError("Could not create URL from components")}
        
        //Далее GET руквест
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
            if let statusCode = httpResponse?.statusCode {
                complition(data, statusCode)
            } else {
                print (httpResponse!.allHeaderFields)
                complition(data, 0)
            }
        }
        task.resume()
    }
    
    //получаем пользователя по id
    static func getUser(id: Int, token: String, complition: @escaping (Data, Int) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pocketmsg.ru"
        urlComponents.path = "/v1/users/"+"\(id)"
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
    
    //Получаем пользователя по никнейму
    static func getUserByNickname(nickname: String, token: String, complition: @escaping (Data, Int) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pocketmsg.ru"
        urlComponents.path = "/v1/users/"+nickname
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
    
    //Получаем пользователя по email
    static func getUserByEmail(email: String, token: String, complition: @escaping (Data, Int) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pocketmsg.ru"
        urlComponents.path = "/v1/users/"+email
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
    
    //Получаем контакты
    static func getContacts(token: String, complition: @escaping (Data, Int) -> Void) {
        
        //GET request
        guard let url = URL(string: "https://pocketmsg.ru:8888/v1/account/contacts/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        var header = request.allHTTPHeaderFields ?? [:]
        header["token"] = token
        request.allHTTPHeaderFields = header
        
        // Request и получение ответа от сервера
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, error) in
            guard let data = responseData, error == nil else {
                print("Ошибка: \(error?.localizedDescription ?? "Error")")
                return
            }
            let httpResponse = response as? HTTPURLResponse
            if let statusCode = httpResponse?.statusCode {
                
                complition(data, statusCode)
            } else {
                print (httpResponse!.allHeaderFields)
                complition(data, 0)
            }
        }
        task.resume()
    }
    
    //MARK: Add user by e-mail
    static func addUserByMail(_ email: String, token: String, complition: @escaping (Data, Int) -> Void) {
        
        //POST request
        guard let url = URL(string: "https://pocketmsg.ru:8888/v1/account/contacts/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var header = request.allHTTPHeaderFields ?? [:]
        header["token"] = token
        request.allHTTPHeaderFields = header
        
        // делаем JSON
        let httpBody = ["contact": email]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: httpBody)
            print("jsondata: ", String(data: request.httpBody!, encoding: .utf8) ?? "No body data")
        }
        catch {
            print (error.localizedDescription)
        }
        
        // Request и получение ответа от сервера
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, error) in
            guard let data = responseData, error == nil else {
                print("Ошибка: \(error?.localizedDescription ?? "Error")")
                return
            }
            let httpResponse = response as? HTTPURLResponse
            if let statusCode = httpResponse?.statusCode, statusCode == 201 {
                print ("statusCode = \(statusCode)")
                complition(data, statusCode)
            } else {
                print (httpResponse!.allHeaderFields)
                complition(data, 0)
            }
        }
        task.resume()
    }
    
    //Delete user by e-mail
    static func deleteUserByMail(_ email: String, token: String, complition: @escaping (Data, Int) -> Void) {
        
        //POST request
        guard let url = URL(string: "https://pocketmsg.ru:8888/v1/account/contacts/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        var header = request.allHTTPHeaderFields ?? [:]
        header["token"] = token
        request.allHTTPHeaderFields = header
        
        // делаем JSON
        let httpBody = ["contact": email]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: httpBody)
            print("jsondata: ", String(data: request.httpBody!, encoding: .utf8) ?? "No body data")
        }
        catch {
            print (error.localizedDescription)
        }
        
        // Request и получение ответа от сервера
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, error) in
            guard let data = responseData, error == nil else {
                print("Ошибка: \(error?.localizedDescription ?? "Error")")
                return
            }
            let httpResponse = response as? HTTPURLResponse
            if let statusCode = httpResponse?.statusCode, statusCode == 201 {
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
