//
//  CreateNewChatVC.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/6/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit
import Firebase

class CreateNewChatVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    
//    var emailArray = [String]()
//    static var chosenEmailArray = [String]()
    var chosenUserArray = [String]()
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        chosenUserArray = DataService.instance.chosenUserArray
        tableView.reloadData()
        super.viewDidLoad()
//        emailSearshTextField.delegate = self
//        emailSearshTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        chosenUserArray = DataService.instance.chosenUserArray
        if chosenUserArray.count >= 1 {
            doneBtn.isEnabled = true
        } else {
            doneBtn.isEnabled = false
        }
        tableView.reloadData()
        super.viewWillAppear(animated)
    }
    
//    @objc func textFieldDidChange(){
//        if emailSearshTextField.text == "" {
//            showingEmailArray = [] + self.chosenUserArray
//            tableView.reloadData()
//        } else {
//            DataService.instance.getEmail(forSearchQuery: emailSearshTextField.text!) { (emailArray) in
//                self.showingEmailArray = emailArray
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    @IBAction func doneBtnWasPressed(_ sender: Any) {
        if chosenUserArray.count > 0 {
            if titleTextField.text != "" && descriptionTextField.text != "" {
                DataService.instance.getIds(forUserNames: chosenUserArray) { (idsArray) in
                    var userIds = idsArray
                    userIds.append((Auth.auth().currentUser?.uid)!)
                    
                    DataService.instance.createDiscussion(withTitle: self.titleTextField.text!, andDescription: self.descriptionTextField.text!, forUserIds: userIds, handler: { (discussionCreated) in
                        if discussionCreated {
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            print("Discussion could not be created. Please try again.")
                        }
                    })
                }
            }
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        DataService.instance.setChosenUserArray(chosenUserArray: [])
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreateNewChatVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenUserArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell()}
        let profileImage = UIImage(named: "defaultProfileImage")
        cell.configureCell(profileImage: profileImage!, email: chosenUserArray[indexPath.row], isSelected: true)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
//        if !chosenUserArray.contains(cell.emailLbl.text!){
//            chosenUserArray.append(cell.emailLbl.text!)
//            doneBtn.isHidden = false
//        } else {
//            if chosenUserArray.count >= 1 {
//                doneBtn.isHidden = false
//            } else {
//                doneBtn.isHidden = true
//            }
//        }
//    }
}
