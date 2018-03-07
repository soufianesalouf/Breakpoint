//
//  DataService.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/5/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _chosenUserArray = [String]()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_DISCUSSION = DB_BASE.child("discussion")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var chosenUserArray: [String] {
        return _chosenUserArray
    }
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_DISCUSSION: DatabaseReference {
        return _REF_DISCUSSION
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    func setChosenUserArray(chosenUserArray: [String]){
        self._chosenUserArray = chosenUserArray
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>){
            REF_USERS.child(uid).updateChildValues(userData)
        }
    
    func getUserName(forUID uid: String, handler: @escaping (_ username: String) -> ()){
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func uploadPost(withMessage message: String, forUID uid: String , withGoupKey groupKey: String?, sendCompletion: @escaping (_ status: Bool) -> () ){
        if groupKey != nil {
            
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendCompletion(true)
        }
    }
    
    func getAllFeedMessages(handler: @escaping (_ messages: ([Message])) -> ()){
        var messagesArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessagesSnapshot) in
            guard let feedMessagesSnapshot = feedMessagesSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for message in feedMessagesSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                
                let message = Message(content: content, senderId: senderId)
                messagesArray.append(message)
            }
            handler(messagesArray)
        }
    }
    
    func getEmail(forSearchQuery query: String, handler: @escaping(_ emailArray: [String]) -> ()){
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getIds(forUserNames userNames: [String], handler: @escaping(_ uidArray: [String]) -> () ){
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            var idArray = [String]()
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if userNames.contains(email) {
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
    }
    
    func createDiscussion(withTitle title: String, andDescription description: String, forUserIds ids: [String],handler: @escaping (_ discussionCreated: Bool) -> () ){
        REF_DISCUSSION.childByAutoId().updateChildValues(["title": title, "description": description, "members": ids])
        handler(true)
    }
    
    func getAllDiscussion(handler: @escaping (_ discussionArray: [Discussion]) -> ()){
        var discussionArray = [Discussion]()
        REF_DISCUSSION.observeSingleEvent(of: .value) { (discussionSnapshot) in
            guard let discussionSnapshot = discussionSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for discussion in discussionSnapshot {
                let memberArray = discussion.childSnapshot(forPath: "members").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.uid)!){
                    let title = discussion.childSnapshot(forPath: "title").value as! String
                    let description = discussion.childSnapshot(forPath: "description").value as! String
                    let discussion = Discussion(title: title, description: description, key: discussion.key, members: memberArray, memberCount: memberArray.count)
                    discussionArray.append(discussion)
                }
            }
            handler(discussionArray)
        }
    }
    
}
