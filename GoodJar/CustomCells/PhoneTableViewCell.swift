//
//  PhoneTableViewCell.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/7/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class PhoneTableViewCell: UITableViewCell {

    @IBOutlet weak var phoneTextField: UITextField!
    
    var phoneInfo: UserInfo! {
            didSet{
                phoneTextField.text = phoneInfo.phone
            }
        }
    
    @IBAction func clearLabelButtonPressed(_ sender: Any) {
        
    }
    
}
