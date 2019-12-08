//
//  TOCTableViewController.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/2/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class TOCTableViewController: UITableViewController {
    
    var tableOfContents = ["My Profile", "My Jar", "Settings"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableOfContents.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 
    }

}
