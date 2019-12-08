//
//  EditProfileTableViewController.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/4/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class EditProfileTableViewController: UITableViewController, UITextFieldDelegate {

    
    var userInfo = ["Name", "Username", "Birthday"]
    var privateUserInfo = ["Email", "Phone"]
    
    var userInfoInput: UserInfo!
    var usersInfoInputted: UsersInfo!
    
    var name: NameTableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        

        if userInfoInput == nil {
            userInfoInput = UserInfo()
        }
        
        usersInfoInputted = UsersInfo()
        
//        name = NameTableViewCell()

    }
    
//    PREPAREFORSEGUE??
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        usersInfoInputted.loadData(){
            self.tableView.reloadData()
        }
    }
    
    func updateUserInterface(){
        name.nameLabel.text! = userInfoInput.name
    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func changeProfilePhotoButtonPressed(_ sender: Any) {
    }
    
    @IBAction func cancelBarButtonPressed(_ sender: Any) {
        leaveViewController()
    }
    
    @IBAction func textFieldReturnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
        userInfoInput.name = name.nameLabel.text!
        updateUserInterface()
    }
    
    @IBAction func doneBarButtonPressed(_ sender: Any) {
        userInfoInput.name = name.nameLabel.text!
        
        userInfoInput.saveData { success in
            if success {
                self.leaveViewController()
            }else{
                print ("*** ERROR Counldn't leave this  View Controller because data wasn't saved")
            }
        }
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profilePhotoCell", for: indexPath) as! ProfilePhotoTableViewCell
            return cell
        } else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! NameTableViewCell
            cell.textLabel?.text = userInfo[0]
//            cell.userNameInfo = usersInfoInputted.userInformation[0]
//            cell.nameLabel.delegate = self
//            cell.nameLabel.text = userInfoInput.name
            return cell
        } else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "userNameCell", for: indexPath) as! UserNameTableViewCell
            cell.textLabel?.text = userInfo[1]
//            cell.userUserNameInfo = usersInfoInputted.userInformation[1]
//            cell.userNameTextField.delegate = self
//            cell.userNameTextField.text = userInfoInput.userName
            return cell
        } else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "birthdayCell", for: indexPath) as! BirthdayTableViewCell
            cell.textLabel?.text = userInfo[2]
//            cell.birthdayInfo = usersInfoInputted.userInformation[2]
//            cell.birthdayLabel.delegate = self
//            cell.birthdayLabel.text = userInfoInput.birthday
            cell.separatorInset = .zero
            return cell
        } else if indexPath.row == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "privateTitleCell", for: indexPath) as! PrivateTitleTableViewCell
            return cell
        } else if indexPath.row == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "emailCell", for: indexPath) as! EmailTableViewCell
            cell.textLabel?.text = privateUserInfo[0]
//            cell.emailInfo = usersInfoInputted.userInformation[3]
//            cell.emailTextField.delegate = self
//            cell.emailTextField.text = userInfoInput.email
            return cell
        } else if indexPath.row == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: "phoneCell", for: indexPath) as! PhoneTableViewCell
            cell.textLabel?.text = privateUserInfo[1]
//            cell.phoneInfo = usersInfoInputted.userInformation[4]

//            cell.phoneTextField.delegate = self
//            cell.phoneTextField.text = userInfoInput.phone
            cell.separatorInset = .zero
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "blankCell", for: indexPath) as! BlankTableViewCell
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 200
        } else if indexPath.row == 7{
            return 389
        } else{
            return 47
        }
    }

    
}
