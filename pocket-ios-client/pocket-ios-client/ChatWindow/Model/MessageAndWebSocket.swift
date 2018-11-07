//
//  MessageAndWebSocket.swift
//  pocket-ios-client
//
//  Created by Мак on 23/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation
import Starscream

class MessageAndWebSocket: WebSocketDelegate {
    
    var socket: WebSocket!
    var messageInOut = [String]()
    
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(String(describing: error?.localizedDescription))")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("got some text: \(text)")
        
        let decoder = JSONDecoder()
        if let jsonData = text.data(using: .utf8) {
            let message = try? decoder.decode(Message.self, from: jsonData)
            if let msg = message?.message, let sndID = message?.receiver {
                messageInOut.append("\(sndID): \(msg)")
            }
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
        
    }
    
    //MARK: Message sending
    func sendMessage (receiver: Int, message: String) {
        messageInOut.append("Я: \(message)")
        let encoder = JSONEncoder()
        let message = Message(receiver: "\(receiver)", message: message, senderid: 78, senderName: "MaxSyt", time: 0)
        
        do {
            let jsonData = try encoder.encode(message)
            socket.write(data: jsonData)
        }
        catch {
            print (error.localizedDescription)
        }
    }
    
    //MARK: WebSocket connecting
    func webSocketConnect() {
        
        let url = URL(string: "wss://pocketmsg.ru:8888/v1/ws/")
        var request = URLRequest(url: url!)
        request.timeoutInterval = 5
        request.setValue(TokenService.getToken(forKey: "token"), forHTTPHeaderField: "token")
        
        self.socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
        
    }
}
