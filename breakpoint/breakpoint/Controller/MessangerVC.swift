//
//  SecondViewController.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/5/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

class MessangerVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var discussionTableView: UITableView!
    
    var discussionArray = [Discussion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discussionTableView.delegate = self
        discussionTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.REF_DISCUSSION.observe(.value) { (snapshot) in
            DataService.instance.getAllDiscussion { (returnedDiscussionsArray) in
                self.discussionArray = returnedDiscussionsArray
                self.discussionTableView.reloadData()
            }
        }
    }


}

extension MessangerVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discussionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = discussionTableView.dequeueReusableCell(withIdentifier: "discussionCell", for: indexPath) as? DiscussionCell else { return UITableViewCell() }
        let discussion = discussionArray[indexPath.row]
        cell.configureCell(title: discussion.discussionTitle , description: discussion.discussionDesc, memberCount: discussion.memberCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let discussionFeedVC = storyboard?.instantiateViewController(withIdentifier: "DiscussionFeedVC") as? DiscussionFeedVC else { return }
        discussionFeedVC.initData(forDiscussion: discussionArray[indexPath.row])
        present(discussionFeedVC, animated:  true , completion: nil)
    }
}
