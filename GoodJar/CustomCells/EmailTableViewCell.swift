//
//  PrivateInfoTableViewCell.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/5/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class EmailTableViewCell: UITableViewCell {

    @IBOutlet weak var emailTextField: UITextField!

    var userInfoInput: UserInfo!

    var emailInfo: UserInfo! {
            didSet{
                emailTextField.text = emailInfo.email
            }
        }
    
    @IBAction func clearLabelButtonPressed(_ sender: Any) {
    }
    
}
