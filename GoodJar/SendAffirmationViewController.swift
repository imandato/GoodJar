//
//  FriendRequestViewController.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/6/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit
import SDWebImage


class SendAffirmationViewController: UIViewController {
    
    @IBOutlet weak var userProfilePhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sendAffirmationButtonPressed: UIButton!
    @IBOutlet weak var affirmationTextField: UITextField!
    
    var affirmation: Affirmation!
    var goodJarUser: GoodJarUser!
    var goodJarUsers: GoodJarUsers!
    var searchVC: SearchViewController!
    var recipientUserID = ""
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        affirmation = Affirmation()
        goodJarUsers = GoodJarUsers()
        searchVC = SearchViewController()
        
        nameLabel.text = goodJarUser.displayName
        guard let url = URL(string: goodJarUser.photoURL ) else{
            userProfilePhoto.image = UIImage(named: "profileStock")
            print("ERROR: cannot convert photoURL String to a URL")
            return
        }
        userProfilePhoto.sd_setImage(with: url, placeholderImage: UIImage(named: "profileStock"))
        recipientUserID = goodJarUser.documentID
    }
    
    
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func submitAffirmationPressed(_ sender: Any) {
//        affirmations.affirmationArray[0].affirmation = affirmationTextView.text!
        affirmation.affirmation = affirmationTextField.text!
        affirmation.recipientUserID = recipientUserID
        affirmation.saveData() { success in
            if success {
                self.leaveViewController()
                print("DATA SAVED")
            } else{
                print ("*** ERROR Counldn't leave this  View Controller because data wasn't saved")
            }
        }
    }
    
    
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }

}
