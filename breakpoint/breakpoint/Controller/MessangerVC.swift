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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discussionTableView.delegate = self
        discussionTableView.dataSource = self
    }


}

extension MessangerVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = discussionTableView.dequeueReusableCell(withIdentifier: "discussionCell", for: indexPath) as? DiscussionCell else { return UITableViewCell() }
        cell.configureCell(title: "Nerd", description: "bla blabbla", memberCount: 3)
        return cell
    }
}
