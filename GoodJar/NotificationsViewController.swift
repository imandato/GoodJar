//
//  NotificationsViewController.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/4/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notifications = ["Friend Suggestions", "Daily Affirmation Reminders", "Turn Off All Notifications",""]
    
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
    @IBAction func notificationsButtonPressed(_ sender: UISwitch) {
    }
    @IBAction func exitBarButtonPressed(_ sender: Any) {
        leaveViewController()
    }
    @IBAction func doneBarButtonPressed(_ sender: UIBarButtonItem) {
    }
    
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          if indexPath.row >= 0 && indexPath.row <= 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "notificationsCell", for: indexPath) as! NotificationsTableViewCell
            cell.textLabel?.text = notifications[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "notificationsBlankCell", for: indexPath) as! NotificationsBlankTableViewCell
            if indexPath.row == 4 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            }
            return cell
        }
    }
    
    
}
