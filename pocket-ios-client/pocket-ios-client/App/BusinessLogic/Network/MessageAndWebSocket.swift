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
    var id: Int? = nil
    
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
            
            let user = DataBase().loadOneContactsList(userId: messageInOut.senderid)
            
            switch user.count{
                case 0:
                    guard let token = Token.main else { return print("Cannot read token") }
                    
                    URLServices().getUserID(id: messageInOut.senderid, token: token) { (contact) in
                        
                        DataBase().saveContacts(data: [contact])
                        
                        DataBase().saveMessages(
                            isOpenChat: self.id,
                            chatId: messageInOut.senderid,
                            chatName: messageInOut.senderName,
                            message: messageInOut
                        )
                    }
                case 1...:
                    DataBase().saveMessages(
                        isOpenChat: id,
                        chatId: messageInOut.senderid,
                        chatName: messageInOut.senderName,
                        message: messageInOut
                    )
                default :
                    print("Negative number of values in Realm response!")
            }
        }
        catch let err {
            print("Err", err)
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
        
    }
    
    //MARK: Message sending
    func sendMessage (receiver: ContactAccount, message: String) -> Message {
        guard let myPersInf = DataBase().loadSelfUser() else { return Message() }
        let msg = Message.init(
            receiver: receiver.uid,
            text: message,
            senderid: myPersInf.uid,
            senderName: myPersInf.accountName,
            time: NSDate().timeIntervalSince1970,
            isEnemy: false
        )
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
        request.setValue(Token.main, forHTTPHeaderField: "token")
        
        self.socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
}

class WSS {
    static let initial = MessageAndWebSocket()
}


