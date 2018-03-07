//
//  DiscussionFeedVC.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/7/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

class DiscussionFeedVC: UIViewController {

    //Outlets
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var discussionTitleLbl: UILabel!
    @IBOutlet weak var messageTextField: InsetTextField!
    @IBOutlet weak var sendView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    
    var discussion : Discussion?
    func initData(forDiscussion discussion: Discussion){
        self.discussion = discussion
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sendView.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        discussionTitleLbl.text = discussion?.discussionTitle
        DataService.instance.getEmailsFor(discussion: discussion!) { (returnedEmails) in
            self.membersLbl.text = returnedEmails.joined(separator: ", ")
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        
    }
    
    
}
