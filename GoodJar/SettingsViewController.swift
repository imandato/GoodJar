//
//  SettingsViewController.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/4/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
   
    
    let settingsMenu = ["Edit Profile", "Password", "Notifications", "Privacy",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = profilePhoto.bounds.width / 2
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier: String
        switch indexPath.row {
        case 0: //For "one"
             segueIdentifier = "showEditProfile"
        case 1: //For "two"
             segueIdentifier = "showPassword"
        case 2:
            segueIdentifier = "showNotifications"
        default:
            segueIdentifier = "showPrivacy"
        }
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }    
    
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func exitBarButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }

    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = settingsMenu[indexPath.row]
        if indexPath.row == 4 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        return cell
    }
    
    
}

