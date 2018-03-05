//
//  InsetTextField.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/5/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

class InsetTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: COLOR_PURPLE_PLACEHOLDER])
        self.attributedPlaceholder = placeholder
    }
    
    
    
    
    
    
//    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return UIEdgeInsetsInsetRect(bounds, padding)
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return UIEdgeInsetsInsetRect(bounds, padding)
//    }
//
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return UIEdgeInsetsInsetRect(bounds, padding)
//    }

}
