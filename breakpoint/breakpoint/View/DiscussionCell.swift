//
//  DiscussionCell.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/6/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

class DiscussionCell: UITableViewCell {
    
    //outlets
    @IBOutlet weak var discussionTitleLbl: UILabel!
    @IBOutlet weak var discussionDescriptionLbl: UILabel!
    @IBOutlet weak var memberCountLbl: UILabel!
    
    func configureCell(title: String, description: String, memberCount: Int){
        self.discussionTitleLbl.text = title
        self.discussionDescriptionLbl.text = description
        self.memberCountLbl.text = "\(memberCount) members."
    }
    

}
