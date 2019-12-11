//
//  PrivacyViewController.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/4/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var blockedUsers = ["blocked"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func exitBarButtonPressed(_ sender: Any) {
        leaveViewController()
    }
    @IBAction func doneBarButtonPressed(_ sender: UIBarButtonItem) {
    }
    
}

extension PrivacyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockedUsers.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "blockUsersCell", for: indexPath) as! BlockUserTableViewCell
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "blockUsersTitleCell", for: indexPath) as! BlockedUsersTitleTableViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "usersBlockedCell", for: indexPath) as! BlockedUsersTableViewCell
                return cell
            }
        }
              
}

