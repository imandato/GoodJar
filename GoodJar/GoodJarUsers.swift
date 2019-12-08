//
//  GoodJarUsers.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/7/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import Foundation
import Firebase

class GoodJarUsers{
    var jarUserArray = [GoodJarUser]()
    var db: Firestore!
    
    init(){
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()){
        db.collection("users").addSnapshotListener{ (querySnapshot, error) in
            guard error == nil else{
                print("ERROR: adding snapshotListener \(error!.localizedDescription)")
                return completed()
            }
            self.jarUserArray = []
            for document in querySnapshot!.documents{
                let jarUser = GoodJarUser(dictionary: document.data())
                jarUser.documentID = document.documentID
                self.jarUserArray.append(jarUser)
            }
            completed()
        }
    }
}
