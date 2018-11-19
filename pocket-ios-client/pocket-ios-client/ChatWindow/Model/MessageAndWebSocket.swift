//
//  MessageAndWebSocket.swift
//  pocket-ios-client
//
//  Created by Мак on 23/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import Foundation
import Starscream

final class MessageAndWebSocket: WebSocketDelegate {
    
    var socket: WebSocket!
    var vc: ChatViewController!
    
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
            let messageInOut = try? decoder.decode(Message.self, from: jsonData)
                
            if let msg = messageInOut {
                userMsgRouter(msg: msg)
            }
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
        
    }
    
    //MARK: Message sending
    func sendMessage (receiver: String, message: String) -> Message {
        let encoder = JSONEncoder()
        let msg = Message(
            receiver: receiver,
            text: message,
            senderid: 78,
            senderName: "MaxSyt",
            time: 0,
            isEnemy: false
        )
        
        do {
            let jsonData = try encoder.encode(msg)
            socket.write(data: jsonData)
        }
        catch {
            print (error.localizedDescription)
        }
        return msg
    }
    
    func userMsgRouter(msg: Message) {

        if (vc != nil) && ((msg.receiver == vc.user?.id) || ("\(msg.senderid)" == vc.user?.id)) {
            vc.chat.append(msg)
            vc.chatField.reloadData()
        }
        FakeData.testMessages.append(msg)
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

class WSS {
    static let initial = MessageAndWebSocket()
}
