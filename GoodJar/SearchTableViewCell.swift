//
//  SearchTableViewCell.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/5/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchProfPhoto: UIImageView!
    @IBOutlet weak var nameSearchLabel: UILabel!
    @IBOutlet weak var usernameSearchLabel: UILabel!
    
    var user: GoodJarUser!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        searchProfPhoto.layer.masksToBounds = true
        searchProfPhoto.layer.cornerRadius = searchProfPhoto.bounds.width / 2
    }
    
    
    var goodJarUser: GoodJarUser! {
        didSet{
            nameSearchLabel.text = goodJarUser.displayName
            usernameSearchLabel.text = goodJarUser.email
            guard let url = URL(string: goodJarUser.photoURL ) else{
                searchProfPhoto.image = UIImage(named: "profileStock")
                print("ERROR: cannot convert photoURL String to a URL")
                return
            }
            searchProfPhoto.sd_setImage(with: url, placeholderImage: UIImage(named: "profileStock"))
        }
    }
    
    
    
    
}

//goodJarUser.photoURL
