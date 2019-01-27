//
//  FullRequestFactory.swift
//  StarShop
//
//  Created by Мак on 01/11/2018.
//  Copyright © 2018 Мак. All rights reserved.
//

import Foundation

protocol FullRequestFactory {
    
    func signIn(login: String, password: String, completion: @escaping (SignInResponse) -> Void)
    func signUp(accountName: String, email: String, password: String, completion: @escaping (SignUpResponse) -> Void)
    func getSelfUser(token: String, completion: @escaping (SelfAccount) -> Void)
    func getUserID(id: Int, token: String, completion: @escaping (ContactAccount) -> Void)
    func getUserByNickname(nickname: String, token: String, completion: @escaping ([ContactAccount]) -> Void)
    func getUserByEmail(email: String, token: String, completion: @escaping (ContactAccount) -> Void)
    func getGroupInfo(info: String, token: String, completion: @escaping (GroupInfo) -> Void)
    func getContacts(token: String, completion: @escaping ([ContactAccount]) -> Void)
    func addUserByMail(_ email: String, token: String, completion: @escaping (ContactAccount) -> Void)
    func deleteUserByMail(_ email: String, token: String, completion: @escaping (DeleteContact) -> Void)
    
}

class URLServices: BaseRequestFatory, FullRequestFactory {
    
    var loginRequest = requestInit.init(path: "/v1/auth/login/", method: "POST")
    var registrRequest = requestInit.init(path: "/v1/auth/register/", method: "POST")
    var selfRequest = requestInit.init(path: "/v1/account/", method: "GET")
    var contactRequest = requestInit.init(path: "", method: "GET")
    var addContactRequest = requestInit.init(path: "/v1/account/contacts/", method: "POST")
    var delContactRequest = requestInit.init(path: "/v1/account/contacts/", method: "DELETE")
    
    func signIn(login: String, password: String, completion: @escaping (SignInResponse) -> Void) {
        loginRequest.parameters = ["account_name": login, "password": password]
        let rqst = try! loginRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    func signUp(accountName: String, email: String, password: String, completion: @escaping (SignUpResponse) -> Void) {
        registrRequest.parameters = ["account_name": accountName, "email": email, "password": password]
        let rqst = try! registrRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    func getSelfUser(token: String, completion: @escaping (SelfAccount) -> Void) {
        selfRequest.header = ["token": token]
        let rqst = try! selfRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    func getUserID(id: Int, token: String, completion: @escaping (ContactAccount) -> Void) {
        contactRequest.header = ["token": token]
        contactRequest.path = "/v1/users/" + "\(id)"
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    func getUserByNickname(nickname: String, token: String, completion: @escaping ([ContactAccount]) -> Void) {
        contactRequest.header = ["token": token]
        contactRequest.path = "/v1/users/" + nickname
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    func getUserByEmail(email: String, token: String, completion: @escaping (ContactAccount) -> Void) {
        contactRequest.header = ["token": token]
        contactRequest.path = "/v1/users/" + email
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func getGroupInfo(info: String, token: String, completion: @escaping (GroupInfo) -> Void) {
        contactRequest.header = ["token": token]
        contactRequest.path = "/v1/chats/" + info
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    func getContacts(token: String, completion: @escaping ([ContactAccount]) -> Void) {
        contactRequest.header = ["token": token]
        contactRequest.path = "/v1/account/contacts/"
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    func addUserByMail(_ email: String, token: String, completion: @escaping (ContactAccount) -> Void) {
        addContactRequest.header = ["token": token]
        addContactRequest.parameters = ["contact": email]
        let rqst = try! addContactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    func deleteUserByMail(_ email: String, token: String, completion: @escaping (DeleteContact) -> Void) {
        delContactRequest.header = ["token": token]
        delContactRequest.parameters = ["contact": email]
        let rqst = try! delContactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
}

extension URLServices {
    
    struct requestInit: RequestRouter {
        var sheme: String = ParametersSetup.sheme
        var host: String = ParametersSetup.host
        var port: Int = ParametersSetup.port
        var path: String
        var method: String
        var header: [String: String]? = nil
        var parameters: [String: String]? = nil
        
        init(path: String, method: String) {
            self.path = path
            self.method = method
        }
    }
}
