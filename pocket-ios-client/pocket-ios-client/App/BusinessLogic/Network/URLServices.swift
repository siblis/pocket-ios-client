//
//  URLServices.swift
//  pocket-ios-client
//
//  Created by Мак on 12/04/2019.
//  Copyright © 2019 Damien Inc. All rights reserved.
//

import Foundation

class URLServices: BaseRequestFatory, FullRequestFactory {
    
    //MARK: - Auth (/auth)
    func signIn(login: String, password: String, completion: @escaping (SignResponse) -> Void) {
        var loginRequest = requestInit.init(path: "/v1/auth/login/", method: "POST")
        loginRequest.parameters = ["email": login, "password": password]
        loginRequest.header = ["Content-Type": "application/json"]
        let rqst = try! loginRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func signUp(accountName: String, email: String, password: String, completion: @escaping (SignResponse) -> Void) {
        var registrRequest = requestInit.init(path: "/v1/auth/registration/", method: "POST")
        registrRequest.parameters = ["name": accountName, "email": email, "password": password]
        registrRequest.header = ["Content-Type": "application/json"]
        let rqst = try! registrRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    //MARK: - Account (/account)
    func getSelfUser(completion: @escaping (User) -> Void) {
        var selfRequest = requestInit.init(path: "/v1/account/", method: "GET")
        selfRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! selfRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func changePassword(email: String, old: String, new: String, completion: @escaping (User) -> Void) {
        var selfRequest = requestInit.init(path: "/v1/account/", method: "PUT")
        selfRequest.parameters = ["name": email, "oldPassword": old, "newPassword": new]
        selfRequest.header = ["Authorization": "Bearer \(Account.token)", "Content-Type": "application/json"]
        let rqst = try! selfRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    //MARK: - Chats (/account/chats)
    func getChats(offset: Int, completion: @escaping (UserChatCollection) -> Void) {
        var chatsRequest = requestInit.init(path: "/v1/account/chats?offset=\(offset)", method: "GET")
        chatsRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! chatsRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    //MARK: - Contacts (/account/contacts)
    func getContactsList(offset: Int, completion: @escaping (UserContactCollection) -> Void) {
        var contactRequest = requestInit.init(path: "/v1/account/contacts?offset=\(offset)", method: "GET")
        contactRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func getContactByID(id: String, completion: @escaping (UserContact) -> Void) {
        var contactRequest = requestInit.init(path: "/v1/account/contacts/" + id, method: "GET")
        contactRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func addNewContact(id: String, name: String?, completion: @escaping (UserContact) -> Void) {
        var contactRequest = requestInit.init(path: "/v1/account/contacts", method: "POST")
        contactRequest.header = ["Authorization": "Bearer \(Account.token)", "Content-Type": "application/json"]
        if let contactName = name {
            contactRequest.parameters = ["user": id, "byname": contactName]
        } else {
            contactRequest.parameters = ["user": id]
        }
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func editContact(id: String, name: String, completion: @escaping (UserContact) -> Void) {
        var contactRequest = requestInit.init(path: "/v1/account/contacts/" + id, method: "PUT")
        contactRequest.header = ["Authorization": "Bearer \(Account.token)", "Content-Type": "application/json"]
        contactRequest.parameters = ["byname": name]
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func deleteContact(id: String, completion: @escaping (UserContact) -> Void) {
        var contactRequest = requestInit.init(path: "/v1/account/contacts/" + id, method: "DELETE")
        contactRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    //MARK: - Blacklist (/account/blacklist)
    func getBlacklist(offset: Int, completion: @escaping (UserBlacklistCollection) -> Void) {
        var contactRequest = requestInit.init(path: "/v1/account/blacklist?offset=\(offset)", method: "GET")
        contactRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func addContactToBlacklist(id: String, completion: @escaping (UserBlacklist) -> Void) {
        var contactRequest = requestInit.init(path: "/v1/account/blacklist", method: "POST")
        contactRequest.header = ["Authorization": "Bearer \(Account.token)", "Content-Type": "application/json"]
        contactRequest.parameters = ["user": id]
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func deleteContactFromBlacklist(id: String, completion: @escaping (UserContact) -> Void) {
        var contactRequest = requestInit.init(path: "/v1/account/contacts/" + id, method: "DELETE")
        contactRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    //MARK: - User (/users)
    func getUserByID(id: String, completion: @escaping (UserProfile) -> Void) {
        var contactRequest = requestInit.init(path: "/v1/users/" + id, method: "GET")
        contactRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func getUserByMail(email: String?, completion: @escaping (UserProfile) -> Void) {
        var contactRequest = requestInit.init(path: "/v1/users?email=\(email ?? String())", method: "GET")
        contactRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! contactRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    //MARK: - Group (/groups)
    func getGroupByID(id: String, invitationCode: String?, completion: @escaping (Groupp) -> Void) {
        var groupRequest = requestInit.init(path: "/v1/groups/" + id, method: "GET")
        groupRequest.header = ["Authorization": "Bearer \(Account.token)", "Content-Type": "application/json"]
        groupRequest.parameters = ["invitation_code": invitationCode ?? ""]
        let rqst = try! groupRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func createGroup(name: String, description: String?, completion: @escaping (Groupp) -> Void) {
        var groupRequest = requestInit.init(path: "/v1/groups", method: "POST")
        groupRequest.header = ["Authorization": "Bearer \(Account.token)", "Content-Type": "application/json"]
        groupRequest.parameters = ["name": name, "description": description ?? ""]
        let rqst = try! groupRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func editGroup(id: String, name: String?, description: String?, completion: @escaping (Groupp) -> Void) {
        var groupRequest = requestInit.init(path: "/v1/groups/" + id, method: "PUT")
        groupRequest.header = ["Authorization": "Bearer \(Account.token)", "Content-Type": "application/json"]
        groupRequest.parameters = ["name": name ?? "", "description": description ?? ""]
        let rqst = try! groupRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func connectToGroup(id: String, invitationCode: String, completion: @escaping (Groupp) -> Void) {
        var groupRequest = requestInit.init(path: "/v1/groups/" + id, method: "LINK")
        groupRequest.header = ["Authorization": "Bearer \(Account.token)", "Content-Type": "application/json"]
        groupRequest.parameters = ["invitation_code": invitationCode]
        let rqst = try! groupRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func disconnectToGroup(id: String, completion: @escaping (Groupp) -> Void) {
        var groupRequest = requestInit.init(path: "/v1/groups/" + id, method: "UNLINK")
        groupRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! groupRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    //MARK: - Group members (/groups/%id/members)
    func getMembers(id: String, offset: Int, completion: @escaping (GroupMemberCollection) -> Void) {
        var groupRequest = requestInit.init(path: "/v1/groups/" + id + "/members?offset=\(offset)", method: "GET")
        groupRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! groupRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func addMember(id: String, addID: String, completion: @escaping (GroupMember) -> Void) {
        var groupRequest = requestInit.init(path: "/v1/groups/" + id + "/members", method: "POST")
        groupRequest.header = ["Authorization": "Bearer \(Account.token)", "Content-Type": "application/json"]
        groupRequest.parameters = ["user": addID]
        let rqst = try! groupRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func changeMemberRights(id: String, chID: String, role: String, completion: @escaping (GroupMember) -> Void) {
        var groupRequest = requestInit.init(path: "/v1/groups/\(id)/members/\(chID)?role=\(role)", method: "PUT")
        groupRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! groupRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func deleteMember(id: String, delID: String, completion: @escaping (GroupMember) -> Void) {
        var groupRequest = requestInit.init(path: "/v1/groups/\(id)/members/\(delID)", method: "DELETE")
        groupRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! groupRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    //MARK: - Group invites (/groups/%id/invites)
    func getInviteStatus(id: String, completion: @escaping (GroupMemberCollection) -> Void) {
        var groupRequest = requestInit.init(path: "/v1/groups/" + id + "/invites", method: "GET")
        groupRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! groupRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func createInvite(id: String, completion: @escaping (GroupMemberCollection) -> Void) {
        var groupRequest = requestInit.init(path: "/v1/groups/" + id + "/invites", method: "POST")
        groupRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! groupRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func deleteInvite(id: String, completion: @escaping (GroupMemberCollection) -> Void) {
        var groupRequest = requestInit.init(path: "/v1/groups/" + id + "/invites", method: "DELETE")
        groupRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! groupRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    //MARK: - User messages (/user/%id/messages)
    func getUserMessages(uID: String, offset: Int, completion: @escaping (MessageCollection) -> Void) {
        var msgRequest = requestInit.init(path: "/v1/user/" + uID + "/messages?offset=\(offset)", method: "GET")
        msgRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! msgRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func getUserOneMessages(uID: String, msgID: String, completion: @escaping (Messag) -> Void) {
        var msgRequest = requestInit.init(path: "/v1/user/" + uID + "/messages/" + msgID, method: "GET")
        msgRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! msgRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    //MARK: - Groups messages (/groups/%id/messages)
    func getGroupMessages(gID: String, offset: Int, completion: @escaping (MessageCollection) -> Void) {
        var msgRequest = requestInit.init(path: "/v1/groups/" + gID + "/messages?offset=\(offset)", method: "GET")
        msgRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! msgRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    func getGroupOneMessages(gID: String, msgID: String, completion: @escaping (Messag) -> Void) {
        var msgRequest = requestInit.init(path: "/v1/groups/" + gID + "/messages/" + msgID, method: "GET")
        msgRequest.header = ["Authorization": "Bearer \(Account.token)"]
        let rqst = try! msgRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
    
    
    //MARK: - WebSocket (/socket)
    func getSocket(completion: @escaping (Messag) -> Void) {
        let msgRequest = requestInit.init(path: "/v1/socket?token=" + Account.token, method: "GET")
        let rqst = try! msgRequest.asURLRequest()
        self.request(ask: rqst, completion: completion)
    }
}


//MARK: - Extension with parameter setup
extension URLServices {
    
    struct requestInit: RequestRouter {
        var sheme: String = ParametersSetup.sheme
        var host: String = ParametersSetup.host
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
