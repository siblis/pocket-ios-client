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
    
    //MARK: Message sending
    func sendMessage (receiver: Int, message: String) {
        let encoder = JSONEncoder()
        let message = Message(receiver: receiver, message: message)
        
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
        request.setValue(UserSetup().getToken(), forHTTPHeaderField: "token")
        
        self.socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
        
        websocketDidConnect(socket: socket)
    }
}
