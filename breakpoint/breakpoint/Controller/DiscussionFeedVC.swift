//
//  DiscussionFeedVC.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/7/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit
import Firebase

class DiscussionFeedVC: UIViewController {

    //Outlets
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var discussionTitleLbl: UILabel!
    @IBOutlet weak var messageTextField: InsetTextField!
    @IBOutlet weak var sendView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    
    var discussion : Discussion?
    var discussionMessages = [Message]()
    
    func initData(forDiscussion discussion: Discussion){
        self.discussion = discussion
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sendView.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        discussionTitleLbl.text = discussion?.discussionTitle
        DataService.instance.getEmailsFor(discussion: discussion!) { (returnedEmails) in
            self.membersLbl.text = returnedEmails.joined(separator: ", ")
        }
        
        DataService.instance.REF_DISCUSSION.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredDiscussion: self.discussion!, handler: { (returnedDiscussionMessages) in
                self.discussionMessages = returnedDiscussionMessages
                self.tableView.reloadData()
                
                if self.discussionMessages.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: self.discussionMessages.count - 1 , section: 0), at: .none , animated: true)
//                    (at: IndexPath(row: (self.discussionMessages.count - 1) , section: 0), at: .none, animated: true)
                }
            })
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if messageTextField.text != "" {
            messageTextField.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTextField.text!, forUID: Auth.auth().currentUser!.uid, withDiscussionKey: discussion?.Key) { (complete) in
                if complete {
                    self.messageTextField.text = ""
                    self.messageTextField.isEnabled = true
                    self.sendBtn.isEnabled = true
                }
            }
        }
    }
    
    
}


extension DiscussionFeedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discussionMessages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "discussionFeedCell") as? DiscussionFeedCell else { return UITableViewCell()}
        let message = discussionMessages[indexPath.row]
        DataService.instance.getUserName(forUID: message.senderId) { (email) in
            cell.configureCell(profileImg: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
        }
        return cell
    }
}








