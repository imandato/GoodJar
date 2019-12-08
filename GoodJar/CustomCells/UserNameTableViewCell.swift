//
//  UserInfoTableViewCell.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/5/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class UserNameTableViewCell: UITableViewCell {
    

    @IBOutlet weak var userNameTextField: UITextField!


   var userUserNameInfo: UserInfo! {
           didSet{
               userNameTextField.text = userUserNameInfo.userName
           }
       }
    

    @IBAction func clearLabelButtonPressed(_ sender: Any) {
    }
    
}
