//
//  FriendRequestViewController.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/6/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class FriendRequestViewController: UIViewController {
    
    @IBOutlet weak var userProfilePhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var affirmationTextView: UITextView!
    @IBOutlet weak var sendAffirmationButtonPressed: UIButton!
    
    var goodJarUsers: GoodJarUsers!
    var affirmation: Affirmation!
    var affirmations: Affirmations!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goodJarUsers = GoodJarUsers()
        affirmation = Affirmation()
        affirmations = Affirmations()
        
        goodJarUsers.loadData {
            self.nameLabel.text! = self.goodJarUsers.jarUserArray[0].displayName
            self.affirmationTextView.text! = "What do you love about \(self.goodJarUsers.jarUserArray[0].displayName)?"
            print("fried: \(self.goodJarUsers)")

        }

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showJarAffirmation" {
                let destination = segue.destination as! JarViewController
                    destination.goodJarUsers = goodJarUsers
                    print("fried: \(goodJarUsers)")
                }
    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func imageTapped(_ sender: Any) {
        affirmationTextView.becomeFirstResponder()
        affirmationTextView.text! = ""
    }
    
    @IBAction func submitAffirmationPressed(_ sender: Any) {
//        affirmations.affirmationArray[0].affirmation = affirmationTextView.text!
        affirmation.affirmation = affirmationTextView.text!
        
        affirmation.saveData() { success in
            if success {
                self.leaveViewController()
                self.affirmationTextView.text! = ""
                self.affirmationTextView.resignFirstResponder()
                
            }else{
                print ("*** ERROR Counldn't leave this  View Controller because data wasn't saved")
            }
        }
    }
    
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }

}
