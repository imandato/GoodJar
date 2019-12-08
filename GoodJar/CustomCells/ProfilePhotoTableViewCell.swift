//
//  ProfilePhotoTableViewCell.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/5/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class ProfilePhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profPhoto: UIImageView!
    @IBOutlet weak var changeProfilePhotoButton: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        profPhoto.layer.masksToBounds = true
        profPhoto.layer.cornerRadius = profPhoto.bounds.width / 2
    }
}
