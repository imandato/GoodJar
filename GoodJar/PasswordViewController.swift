//
//  PasswordViewController.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/4/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!

    var passwords = ["Current Password", "New Password", "New Password"]

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
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func cancelBarButtonPressed(_ sender: Any) {
        leaveViewController()
    }
    
}

extension PasswordViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= 0 && indexPath.row <= 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "passwordCell", for: indexPath) as! PasswordTableViewCell
            cell.textLabel?.text = passwords[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "blankPasswordCell", for: indexPath) as! BlankPasswordTableViewCell
            if indexPath.row == 3 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            }
            return cell
        }
    }
    
    
}
