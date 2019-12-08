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
    @IBOutlet weak var friendRequestButtonPressed: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }

}
