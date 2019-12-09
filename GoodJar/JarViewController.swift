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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yAtBase = messagePopUp.frame.origin.y
        
        affirmations = Affirmations()
    }
    
    
    func loadData(){
        self.affirmationTextView.text! = affirmations.affirmationArray[0].affirmation
        self.userNameLabel.text! = affirmations.affirmationArray[0].userName
    }
    
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
