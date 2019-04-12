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
        webSocketConnect()
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("got some text: \(text)")
        
        guard let jsonData = text.data(using: .utf8) else { return }
        do {
            let messageInOut = try JSONDecoder().decode(Message.self, from: jsonData)
            
            let user = DataBase(.myData).loadOneContactsList(userId: messageInOut.senderid)
            
            switch user.count{
                
            case 0:
                print("Selected 0")
//                URLServices().getUserID(id: messageInOut.senderid, token: Account.token) { (contact) in
//                    
//                    DataBase(.myData).saveContacts(data: [contact])
//                    
//                    DataBase(.myData).saveMessages(
//                        isOpenChat: self.id,
//                        chatId: messageInOut.senderid,
//                        chatName: messageInOut.senderName,
//                        message: messageInOut
//                    )
//                }
            case 1...:
                DataBase(.myData).saveMessages(
                    isOpenChat: self.id,
                    chatId: messageInOut.senderid,
                    chatName: messageInOut.senderName,
                    message: messageInOut
                )
                
            default:
                print("Number of elements in Realm Response is negative!")
                
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
        let myPersInf = DataBase(.accounts).loadSelfUser()
        let msg = Message()// .init(
//            receiver: receiver.uid,
//            text: message,
//            senderid: myPersInf.id,
//            senderName: myPersInf.email,
//            time: NSDate().timeIntervalSince1970,
//            isEnemy: false
//        )
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
        
        let url = URL(string: "https://pocket-java-backend.herokuapp.com/v1/socket?token=\(Account.token)")
        var request = URLRequest(url: url!)
        request.timeoutInterval = 10
//        request.setValue(Account.token, forHTTPHeaderField: "token")
        
        self.socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
}

class WSS {
    static let initial = MessageAndWebSocket()
}
