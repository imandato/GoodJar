//
//  GoodJarUser.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/6/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import Foundation
import Firebase

class GoodJarUser {
    var displayName: String
    var email: String
    var photoURL: String
    var documentID: String
    
    var dictionary: [String: Any] {
        return [ "displayName": displayName,  "email": email,  "photoURL": photoURL, "documentID": documentID]
    }
    
    init(displayName: String, email: String, photoURL: String, documentID: String) {
        self.displayName = displayName
        self.email = email
        self.photoURL = photoURL
        self.documentID = documentID
    }
    
    convenience init(user: User) {
        self.init(displayName: user.displayName ?? "",  email: user.email ?? "", photoURL:(user.photoURL != nil ? "\(user.photoURL!)" : ""), documentID: user.uid)
    }
    
    convenience init(dictionary: [String: Any?]){
        
        let displayName = dictionary["displayName"] as! String? ?? ""
        let email = dictionary["email"] as! String? ?? ""
        let photoURL = dictionary["photoURL"] as! String? ?? ""
        
        
        self.init(displayName: displayName, email: email, photoURL: photoURL, documentID: "")
    }
    
    func saveIfNewUser() {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(documentID)
        userRef.getDocument { (document, error) in
            guard error == nil else {
                print("😡 ERROR: could not access document for user \(userRef.documentID)")
                return
            }
            guard document?.exists == false else {
                print("^^^ The document for user \(self.documentID) already exits. No reason to create it.")
                return
            }
            self.saveData()
        }
    }
    
    func saveData() {
        let db = Firestore.firestore()
        let dataToSave: [String: Any] = self.dictionary
        db.collection("users").document(documentID).setData(dataToSave) { error in
            if let error = error {
                print("😡 ERROR: \(error.localizedDescription), could not save data for \(self.documentID)")
            }
        }
        
    }
 
}
