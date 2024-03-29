//
//  NewEditProfileViewController.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/7/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePhotoSettings: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var userInfoInput: UserInfo!
    var usersInfoInputted: UsersInfo!
    var goodJar: GoodJarUsers!
    var goodJarUser: GoodJarUser!
//    var email: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePhotoSettings.layer.masksToBounds = true
        profilePhotoSettings.layer.cornerRadius = profilePhotoSettings.bounds.width / 2

        if userInfoInput == nil {
            userInfoInput = UserInfo()
        }
        usersInfoInputted = UsersInfo()
        loadData()
        
        goodJar = GoodJarUsers()
        
        

    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        loadData()
//        print(email)
        }
        
    
    



    func loadData(){
        usersInfoInputted.loadData {
            self.nameTextField.text! = self.usersInfoInputted.userInformation[0].name
            self.userNameTextField.text! = self.usersInfoInputted.userInformation[0].userName
            self.birthdayTextField.text! = self.usersInfoInputted.userInformation[0].birthday
            self.emailTextField.text! = self.usersInfoInputted.userInformation[0].email
            self.phoneTextField.text! = self.usersInfoInputted.userInformation[0].phone
        }

    }
    
    
    func updateUserInterface(){
        nameTextField.text! = userInfoInput.name
        userNameTextField.text! = userInfoInput.userName
        birthdayTextField.text! = userInfoInput.birthday
        emailTextField.text! = userInfoInput.email
        phoneTextField.text! = userInfoInput.phone
    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    
    @IBAction func changeProfilePhotoButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func nameTextFieldReturnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
        userInfoInput.name = nameTextField.text!
//        updateUserInterface()
    }

    @IBAction func userNameTextFieldReturnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
        userInfoInput.userName = userNameTextField.text!
//        updateUserInterface()
    }

    @IBAction func birthdayTextFieldReturnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
        userInfoInput.birthday = birthdayTextField.text!
//        updateUserInterface()
    }

    @IBAction func emailTextFieldReturnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
        userInfoInput.email = emailTextField.text!
//        updateUserInterface()
    }

    @IBAction func phoneTextFieldReturnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
        userInfoInput.phone = phoneTextField.text!
//        updateUserInterface()
    }
    
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        userInfoInput.name = nameTextField.text!
        userInfoInput.userName = userNameTextField.text!
        userInfoInput.birthday = birthdayTextField.text!
        userInfoInput.email = emailTextField.text!
        userInfoInput.phone = phoneTextField.text!
        
        userInfoInput.saveData() { success in
            if success {
                self.leaveViewController()
            }else{
                print ("*** ERROR Counldn't leave this  View Controller because data wasn't saved")
            }
        }
    }
    
    @IBAction func clearNameButtonPressed(_ sender: UIButton) {
        nameTextField.text! = ""


    }


    @IBAction func clearUserNameButtonPressed(_ sender: UIButton) {
        userNameTextField.text! = ""

    }

    @IBAction func clearBirthdayButtonPressed(_ sender: Any) {
        birthdayTextField.text! = ""

    }

    @IBAction func clearEmailButtonPressed(_ sender: UIButton) {
        emailTextField.text! = ""


    }

    @IBAction func clearPhoneButtonPressed(_ sender: UIButton) {
        phoneTextField.text! = ""

    }
    
}

