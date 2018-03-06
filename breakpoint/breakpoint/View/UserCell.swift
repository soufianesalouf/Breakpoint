//
//  userCell.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/6/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    
    var showing = false
    
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool ){
        self.profileImg.image = image
        self.emailLbl.text = email
        if isSelected {
            self.checkImage.isHidden = false
        } else {
            self.checkImage.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showing == false {
                checkImage.isHidden = false
                showing = true
            } else {
                checkImage.isHidden = true
                showing = false
            }
        }
    }

}
