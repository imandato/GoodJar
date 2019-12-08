//
//  UsersInfo.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/6/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import Foundation
import Firebase

class UsersInfo {
    var userInformation: [UserInfo] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    

    func loadData(completed: @escaping () -> ())  {
        db.collection("usersInfo").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.userInformation = []
            // there are querySnapshot!.documents.count documents in teh teams snapshot
            for document in querySnapshot!.documents {
              // You'll have to be sure you've created an initializer in the singular class (Team, below) that acepts a dictionary.
                let userInfo = UserInfo(dictionary: document.data())
                userInfo.documentID = document.documentID
                self.userInformation.append(userInfo)
            }
            completed()
        }
    }
}
