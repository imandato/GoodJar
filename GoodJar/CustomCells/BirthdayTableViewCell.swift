//
//  BirthdayTableViewCell.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/7/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class BirthdayTableViewCell: UITableViewCell {

    @IBOutlet weak var birthdayLabel: UITextField!
    
    var birthdayInfo: UserInfo! {
            didSet{
                birthdayLabel.text = birthdayInfo.birthday
            }
        }
    
    @IBAction func clearLabelButtonPressed(_ sender: Any) {
    }
    
}
