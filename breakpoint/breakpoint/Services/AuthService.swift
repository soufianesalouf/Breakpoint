//
//  AuthService.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/5/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreattionCompletion: @escaping(_ status: Bool, _ error: Error?) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreattionCompletion(false,error)
                return
            }
            
            let userData = ["provider": user.providerID,"email": user.email]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreattionCompletion(true,nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping(_ status: Bool, _ error: Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                loginComplete(false,error)
                return
            }
            loginComplete(true,nil)
        }
    }
}

