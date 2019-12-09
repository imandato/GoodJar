//
//  JarViewController.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/4/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class JarViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var jarImageButton: UIButton!
    @IBOutlet weak var messagePopUp: UIView!
    
    @IBOutlet weak var affirmationTextView: UITextView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var yAtBase: CGFloat!
    
    var affirmations: Affirmations!
    var userInfo: UserInfo!
    var goodJarUsers: GoodJarUsers!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yAtBase = messagePopUp.frame.origin.y
        
        affirmations = Affirmations()
        goodJarUsers = GoodJarUsers()
            
    }
    
    
    
        
    func loadData(){
        affirmations.loadData {
//            self.userNameLabel.text! = self.goodJarUsers.jarUserArray[0].displayName
            self.affirmationTextView.text! = "What do you love about \(self.goodJarUsers.jarUserArray[0].displayName)?"
            print("friend: \(self.goodJarUsers)")
        }
    }

        
//        self.affirmationTextView.text! = affirmations.affirmationArray[0].affirmation
//        affirmations.loadData{
//            self.affirmationTextView.text! = self.affirmations.affirmationArray[0].affirmation
//            self.affirmations.affirmationArray[0].recipientUserID = self.goodJarUsers.jarUserArray[0].documentID
//        }
//    }
    
    @IBAction func jarBarButtonPressed(_ sender: Any) {
        loadData()
        UIView.animate(withDuration: 0.0) {
          self.messagePopUp.frame.origin.y = self.messagePopUp.frame.origin.y - 724
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
    
    @IBAction func exitAffirmationButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.0, animations: {self.messagePopUp.frame.origin.y = self.yAtBase})

    }
    
    @IBAction func exitBarButtonPressed(_ sender: Any) {
        leaveViewController()
    }
}
