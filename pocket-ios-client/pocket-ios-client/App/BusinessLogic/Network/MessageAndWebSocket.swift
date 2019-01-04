//
//  MessageAndWebSocket.swift
//  pocket-ios-client
//
//  Created by Мак on 23/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit
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
        
        guard let jsonData = text.data(using: .utf8) else { return }
        do {
            let messageInOut = try JSONDecoder().decode(Message.self, from: jsonData)
            let chat = Chat.init(
                id: messageInOut.senderid,
                chatName: messageInOut.senderName,
                messageCount: 20,
                messages: [messageInOut]
            )
            AdaptationDBJSON().saveInDB([chat])
        }
        catch let err {
            print("Err", err)
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
        
    }
    
    //MARK: Message sending
    func sendMessage (receiver: ContactAccount, message: String) -> Chat {
        
        let msg = Message.init(
            receiver: receiver.uid,
            text: message,
            senderid: 78,
            senderName: "MaxSyt",
            time: NSDate().timeIntervalSince1970,
            isEnemy: false
        )
        let chat = Chat.init(
            id: receiver.uid,
            chatName: receiver.accountName,
            messageCount: 15,
            messages: [msg]
        )
        do {
            let jsonData = try JSONEncoder().encode(msg)
            socket.write(data: jsonData)
        }
        catch {
            print (error.localizedDescription)
        }
        return chat
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
