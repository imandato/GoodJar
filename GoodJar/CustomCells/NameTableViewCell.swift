//
//  NameTableViewCell.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/7/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UITextField!
    
    var userNameInfo: UserInfo! {
            didSet{
                nameLabel.text = userNameInfo.name
            }
        }

    
    @IBAction func clearLabelButtonPressed(_ sender: Any) {
    }
    
}
