//
//  ViewController.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/6/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

class AddMemberVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailSearshTextField: InsetTextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //    var emailArray = [String]()
    var showingEmailArray = [String]()
    var chosenUserArray = [String]()
//    var oldChosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearshTextField.delegate = self
        emailSearshTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        chosenUserArray = DataService.instance.chosenUserArray
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chosenUserArray = DataService.instance.chosenUserArray
        tableView.reloadData()
    }
    
    @objc func textFieldDidChange(){
        if emailSearshTextField.text == "" {
            showingEmailArray = [] + self.chosenUserArray
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearshTextField.text!) { (emailArray) in
                self.showingEmailArray = emailArray
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func doneBtnWasPressed(_ sender: Any) {
            DataService.instance.setChosenUserArray(chosenUserArray: self.chosenUserArray)
            dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddMemberVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showingEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell()}
        let profileImage = UIImage(named: "defaultProfileImage")
        if chosenUserArray.contains(showingEmailArray[indexPath.row]){
            cell.configureCell(profileImage: profileImage!, email: showingEmailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: profileImage!, email: showingEmailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !chosenUserArray.contains(cell.emailLbl.text!){
            chosenUserArray.append(cell.emailLbl.text!)
            doneBtn.isHidden = false
        } else {
            chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLbl.text!})
        }
    }
}

extension AddMemberVC: UITextFieldDelegate {
    
}
