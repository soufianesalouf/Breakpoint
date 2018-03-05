//
//  AuthVC.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/5/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {
    
    //Outlets
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInWithEmailBtnWasPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC! , animated: true, completion: nil)
    }
    
    @IBAction func googleSignInBtnWasPressed(_ sender: Any) {
        
    }
    
    @IBAction func facebookSignInBtnWasPressed(_ sender: Any) {
        
    }
    
}
