//
//  Affirmations.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/9/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import Foundation
import Firebase

class Affirmations{
    var affirmationArray = [Affirmation]()
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }

    func loadData(completed: @escaping () -> ())  {
        db.collection("affirmations").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.affirmationArray = []
            // there are querySnapshot!.documents.count documents in teh teams snapshot
            for document in querySnapshot!.documents {
              // You'll have to be sure you've created an initializer in the singular class (Team, below) that acepts a dictionary.
                let affirmation = Affirmation(dictionary: document.data())
                print(document.documentID)
                affirmation.documentID = document.documentID
                self.affirmationArray.append(affirmation)
            }
            completed()
        }
    }
}
