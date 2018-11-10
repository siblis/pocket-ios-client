//
//  TestViewController.swift
//  pocket-ios-client
//
//  Created by Damien on 30/09/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit
import Foundation
import Starscream

class TestViewController: UIViewController, WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocketClient) {
      print("websocket is connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(String(describing: error?.localizedDescription))")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("got some text: \(text)")
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
    }
    
    
    var socket: WebSocket!
    
    
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var massageOut: UITextField!
    
    @IBAction func sendBottom(_ sender: Any) {
        
//        let encoder = JSONEncoder()
//        let message = Message(receiver: 24, message: "Hello, im iOS client", senderid: 0, sender_name: "")
        
//        do {
//            let jsonData = try encoder.encode(message)
//            socket.write(data: jsonData)
//        }
//        catch {
//            print (error.localizedDescription)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let getRegistered = Post(account_name: "", email: "", password: "")
//        let user = User(account_name: "", password: "")
        
        
        // Логин
        //registerUser(post: getRegistered)
        //login(user: user)
        getSelf()
        webSocketConnect()
        
    }
    
    // Web Socket Connect
    
    func webSocketConnect() {
        
        let url = URL(string: "wss://pocketmsg.ru:8888/v1/ws/")
        var request = URLRequest(url: url!)
        request.timeoutInterval = 5
        request.setValue(TokenService.getToken(forKey: "token"), forHTTPHeaderField: "token")
        
       self.socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
        
        websocketDidConnect(socket: socket)
    }
    
    
    //Регистрация
    func registerUser(post: Post) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pocketmsg.ru"
        urlComponents.path = "/v1/users/"
        urlComponents.port = 8888
        
        guard let url = urlComponents.url else {fatalError("Could not create URL from components")}
        
        //Далее Post руквест
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(post)
            request.httpBody = jsonData
            print("jsondata: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        }
        catch {
            print (error.localizedDescription)
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, error) in
            guard error == nil else {
                print("Ошибка: \(error!)")
                return}
            
            if let data = responseData, let uft8Representation = String(data: data, encoding: .utf8) {
                print("Сообщение сервера: \(uft8Representation)")
            }
            else {
                print ("Нет даты")
            }
        }
        task.resume()
    }
    
    // ---------------
    
    //Логирование
    func login(user: User) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pocketmsg.ru"
        urlComponents.path = "/v1/auth/"
        urlComponents.port = 8888
        
        guard let url = urlComponents.url else {fatalError("Could not create URL from components")}
        
        //Далее PUT руквест
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(user)
            request.httpBody = jsonData
            print("jsondata: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        }
        catch {
            print (error.localizedDescription)
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, error) in
            guard error == nil else {
                print("Ошибка: \(error!)")
                return}
            
            if let data = responseData, let uft8Representation = String(data: data, encoding: .utf8) {
                print("Сообщение сервера: \(uft8Representation)")
                
                let stringSplit = uft8Representation.split(separator: "\"")
//                self.userSetup.setToken(token: String(stringSplit[3]))
                
                
                //                do {
                //                    json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                //                    print ("Json: \(json)")
                //                } catch {
                //                    print(error)
                //                }
                
            }
            else {
                print ("Нет информации")
            }
        }
        task.resume()
        
    }
    // ---------------
    
    // Получить данные юзера
    
    func getSelf() {
        
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
        header["token"] = TokenService.getToken(forKey: "token")
        request.allHTTPHeaderFields = header
        //
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, error) in
            guard error == nil else {
                print("Ошибка: \(error!)")
                return}
            
            if let data = responseData, let uft8Representation = String(data: data, encoding: .utf8) {
                print("Сообщение сервера: \(uft8Representation)")
            }
            else {
                print ("Нет даты")
            }
        }
        task.resume()
    }
}
