//
//  UIViewControllerExt.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/7/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetail(_ viewControllerPresent: UIViewController){
        self.view.window?.layer.add(getTransition(direction: kCATransitionFromRight), forKey: kCATransition)
        present(viewControllerPresent, animated: false, completion: nil)
    }
    
    func presentSecondaryDetail(_ viewControllerPresent: UIViewController){
        guard let presentedViewController = presentedViewController else { return }
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(self.getTransition(direction: kCATransitionFromRight), forKey: kCATransition)
            self.present(viewControllerPresent, animated: false, completion: nil)
        }
    }
    
    func dismissDetail(){
        self.view.window?.layer.add(getTransition(direction: kCATransitionFromLeft), forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
    
    func getTransition(direction: String ) -> CATransition {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = direction
        return transition
    }
}
