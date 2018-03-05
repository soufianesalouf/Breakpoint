//
//  RoundedView.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/5/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedShadowView: UIView {
    
    override func awakeFromNib() {
        //Rounded
        self.layer.cornerRadius = 10
        
        //setShadow
        self.layer.shadowOpacity = 0.10
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        super.awakeFromNib()
    }

//    override func layoutSubviews() {
//        self.layer.cornerRadius = 14
//    }
    
}
