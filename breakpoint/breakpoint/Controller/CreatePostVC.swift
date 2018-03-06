//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/5/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var profilImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postBtn: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
    }
    
    @IBAction func postBtnWasPressed(_ sender: Any) {
        if textView.text != nil && textView.text != "What's on your mind ?" {
            postBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text, forUID: (Auth.auth().currentUser?.uid)!, withGoupKey: nil) { (success) in
                if success {
                    self.postBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.postBtn.isEnabled = true
                    print("There was an error!")
                }
            }
        }
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreatePostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
