//
//  Affirmation.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/9/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import Foundation
import Firebase

//class Affirmation {
//    var userName: String
//    var affirmation: String
//    var postingUserID: String
//    var documentID: String
//
//    var dictionary: [String: Any] {
//        return ["userName": userName, "affirmation": affirmation, "postingUserID": postingUserID]
//    }
//
//    init(userName: String, affirmation: String, documentID: String, postingUserID: String) {
//        self.userName = userName
//        self.affirmation = affirmation
//        self.documentID = documentID
//        self.postingUserID = postingUserID
//    }
//
//
//    convenience init(dictionary: [String: Any]) {
//        let userName = dictionary["userName"] as! String? ?? ""
//        let affirmation = dictionary["affirmation"] as! String? ?? ""
//        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
//        self.init(userName: userName, affirmation: "", documentID: "", postingUserID: "")
//    }
//
//    convenience init() {
//        self.init(userName: "", affirmation: "", documentID: "", postingUserID: "")
//    }
//
//    func saveData(userInfo: UserInfo, completion: @escaping (Bool) -> ())  {
//        let db = Firestore.firestore()
//        // Grab the user ID
//
//        // Create the dictionary representing data we want to save
//        let dataToSave = self.dictionary
//        // if we HAVE saved a record, we'll have an ID
//        if self.documentID != "" {
//            let ref = db.collection("usersInfo").document(userInfo.documentID).collection("affirmations").document(self.documentID)
//            ref.setData(dataToSave) { (error) in
//                if let error = error {
//                    print("ERROR: updating document \(self.documentID) in userInfo \(userInfo.documentID) \(error.localizedDescription)")
//                    completion(false)
//                } else { // It worked!
//                    print("^^^ Document updated with ref ID \(ref.documentID)")
//                    completion(true)
//                }
//            }
//        } else { // Otherwise create a new document via .addDocument
//            var ref: DocumentReference? = nil // Firestore will creat a new ID for us
//            ref = db.collection("usersInfo").document(userInfo.documentID).collection("affirmations").addDocument(data: dataToSave) { (error) in
//                if let error = error {
//                    print("ERROR: adding document \(self.documentID) in userInfo \(userInfo.documentID) \(error.localizedDescription)")
//                    completion(false)
//                } else { // It worked! Save the documentID in Teams’s documentID property
//                    print("^^^ Document new doc created with ref ID \(ref?.documentID ?? "Unkown")")
//                    self.documentID = ref!.documentID
//                    completion(true)
//                }
//            }
//        }
//    }
//}


class Affirmation {

    var userName: String
    var affirmation: String
    var postingUserID: String
    var recipientUserID: String
    var documentID: String

    var dictionary: [String: Any] {
        return ["userName": userName, "affirmation": affirmation, "postingUserID": postingUserID, "recipientUserID": recipientUserID]
    }

    init(userName: String, affirmation: String, documentID: String, postingUserID: String, recipientUserID: String) {
        self.userName = userName
        self.affirmation = affirmation
        self.documentID = documentID
        self.postingUserID = postingUserID
        self.recipientUserID = recipientUserID
    }


    convenience init(dictionary: [String: Any]) {
        let userName = dictionary["userName"] as! String? ?? ""
        let affirmation = dictionary["affirmation"] as! String? ?? ""
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        let recipientUserID = dictionary["recipientUserID"] as! String? ?? ""
        self.init(userName: userName, affirmation: "", documentID: "", postingUserID: "", recipientUserID: "")
    }

    convenience init() {
        self.init(userName: "", affirmation: "", documentID: "", postingUserID: "", recipientUserID: "")
    }
    
    func saveData(completion: @escaping (Bool) -> ())  {
        let db = Firestore.firestore()
        // Grab the user ID
        guard let postingUserID = (Auth.auth().currentUser?.uid) else {
            print("*** ERROR: Could not save data because we don't have a valid postingUserID")
            return completion(false)
        }
        self.postingUserID = postingUserID
        // Create the dictionary representing data we want to save
        let dataToSave: [String: Any] = self.dictionary
        // if we HAVE saved a record, we'll have an ID
        if self.documentID != "" {
            let ref = db.collection("affirmations").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("ERROR: updating document \(error.localizedDescription)")
                    completion(false)
                } else { // It worked!
                    completion(true)
                }
            }
        } else { // Otherwise create a new document via .addDocument
            var ref: DocumentReference? = nil // Firestore will creat a new ID for us
            ref = db.collection("affirmations").addDocument(data: dataToSave) { (error) in
                if let error = error {
                    print("ERROR: adding document \(error.localizedDescription)")
                    completion(false)
                } else { // It worked! Save the documentID in Teams’s documentID property
                    self.documentID = ref!.documentID
                    completion(true)
                }
            }
        }
    }
}

