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
    private var _REF_GROUPS = DB_BASE.child("groups")
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
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
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
    
}
