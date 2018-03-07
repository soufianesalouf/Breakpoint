//
//  DiscussionFeedCell.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/7/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

class DiscussionFeedCell: UITableViewCell {
    
    //Outlets
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    func configureCell(profileImg: UIImage, email: String, content: String){
        self.emailLbl.text = email
        self.profileImg.image = profileImg
        self.contentLbl.text = content
    }

}
