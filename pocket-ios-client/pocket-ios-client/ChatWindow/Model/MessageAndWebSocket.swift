//
//  MessageAndWebSocket.swift
//  pocket-ios-client
//
//  Created by Мак on 23/10/2018.
//  Copyright © 2018 Damien Inc. All rights reserved.
//

import UIKit
import Starscream
import RealmSwift

final class MessageAndWebSocket: WebSocketDelegate {
    
    var socket: WebSocket!
    var vc: ChatViewController!
    let realm = try! Realm()
    
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
            AdaptationDBJSON().saveInDB([messageInOut])
        }
        catch let err {
            print("Err", err)
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
        
    }
    
    //MARK: Message sending
    func sendMessage (receiver: Int, message: String) -> Message {
        
        let msg = Message.init(
            receiver: receiver,
            text: message,
            senderid: 78,
            senderName: "MaxSyt",
            time: NSDate().timeIntervalSince1970,
            isEnemy: false
        )
        AdaptationDBJSON().saveInDB([msg])
        do {
            let jsonData = try JSONEncoder().encode(msg)
            socket.write(data: jsonData)
        }
        catch {
            print (error.localizedDescription)
        }
        return msg
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
