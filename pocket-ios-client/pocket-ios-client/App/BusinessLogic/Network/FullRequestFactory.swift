//
//  FullRequestFactory.swift
//  pocket-ios-client
//
//  Created by Мак on 01/11/2018.
//  Copyright © 2018 Мак. All rights reserved.
//

import Foundation


protocol FullRequestFactory {
    
    //MARK: - Auth (/auth)
    func signIn(login: String, password: String, completion: @escaping (SignResponse) -> Void)
    func signUp(accountName: String, email: String, password: String, completion: @escaping (SignResponse) -> Void)
    
    //MARK: - Account (/account)
    func getSelfUser(completion: @escaping (User) -> Void)
    func changePassword(email: String, old: String, new: String, completion: @escaping (User) -> Void)
    
    //MARK: - Chats (/account/chats)
    func getChats(offset: Int, completion: @escaping (UserChatCollection) -> Void)
    
    //MARK: - Contacts (/account/contacts)
    func getContactsList(offset: Int, completion: @escaping (UserContactCollection) -> Void)
    func getContactByID(id: String, completion: @escaping (UserContact) -> Void)
    func addNewContact(id: String, name: String?, completion: @escaping (UserContact) -> Void)
    func editContact(id: String, name: String, completion: @escaping (UserContact) -> Void)
    func deleteContact(id: String, completion: @escaping (UserContact) -> Void)
    
    //MARK: - Blacklist (/account/blacklist)
    func getBlacklist(offset: Int, completion: @escaping (UserBlacklistCollection) -> Void)
    func addContactToBlacklist(id: String, completion: @escaping (UserBlacklist) -> Void)
    func deleteContactFromBlacklist(id: String, completion: @escaping (UserContact) -> Void)
    
    //MARK: - User (/users)
    func getUserByID(id: String, completion: @escaping (UserProfile) -> Void)
    func getUserByMail(email: String?, completion: @escaping (UserProfile) -> Void)
    
    //MARK: - Group (/groups)
    func getGroupByID(id: String, invitationCode: String?, completion: @escaping (Groupp) -> Void)
    func createGroup(name: String, description: String?, completion: @escaping (Groupp) -> Void)
    func editGroup(id: String, name: String?, description: String?, completion: @escaping (Groupp) -> Void)
    func connectToGroup(id: String, invitationCode: String, completion: @escaping (Groupp) -> Void)
    func disconnectToGroup(id: String, completion: @escaping (Groupp) -> Void)
    
    //MARK: - Group members (/groups/%id/members)
    func getMembers(id: String, offset: Int, completion: @escaping (GroupMemberCollection) -> Void)
    func addMember(id: String, addID: String, completion: @escaping (GroupMember) -> Void)
    func changeMemberRights(id: String, chID: String, role: String, completion: @escaping (GroupMember) -> Void)
    func deleteMember(id: String, delID: String, completion: @escaping (GroupMember) -> Void)
    
    //MARK: - Group invites (/groups/%id/invites)
    func getInviteStatus(id: String, completion: @escaping (GroupMemberCollection) -> Void)
    func createInvite(id: String, completion: @escaping (GroupMemberCollection) -> Void)
    func deleteInvite(id: String, completion: @escaping (GroupMemberCollection) -> Void)
    
    //MARK: - User messages (/user/%id/messages)
    func getUserMessages(uID: String, offset: Int, completion: @escaping (MessageCollection) -> Void)
    func getUserOneMessages(uID: String, msgID: String, completion: @escaping (Messag) -> Void)
    
    //MARK: - Groups messages (/groups/%id/messages)
    func getGroupMessages(gID: String, offset: Int, completion: @escaping (MessageCollection) -> Void)
    func getGroupOneMessages(gID: String, msgID: String, completion: @escaping (Messag) -> Void)
    
    //MARK: - WebSocket (/socket)
    func getSocket(completion: @escaping (Messag) -> Void)
}
