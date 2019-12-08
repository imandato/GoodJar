//
//  UserInfo.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/6/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import Foundation
import Firebase

class UserInfo {
    var name: String
    var userName: String
    var birthday: String
    var email: String
    var phone: String
    var postingUserID: String
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["name": name, "userName": userName, "birthday": birthday, "email": email, "phone": phone, "postingUserID": postingUserID]
    }

    init(name: String, userName: String, birthday: String, email: String, phone: String, documentID: String, postingUserID: String) {
        self.name = name
        self.userName = userName
        self.birthday = birthday
        self.email = email
        self.phone = phone
        self.documentID = documentID
        self.postingUserID = postingUserID
    }
    
    convenience init() {
        self.init(name: "", userName: "", birthday: "", email: "",
                  phone: "", documentID: "", postingUserID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let name = dictionary["name"] as! String? ?? ""
        let userName = dictionary["userName"] as! String? ?? ""
        let birthday = dictionary["birthday"] as! String? ?? ""
        let email = dictionary["email"] as! String? ?? ""
        let phone = dictionary["phone"] as! String? ?? ""
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        self.init(name: name, userName: userName, birthday: birthday, email: email, phone: phone, documentID: "", postingUserID: "")
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
            let ref = db.collection("usersInfo").document(self.documentID)
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
            ref = db.collection("usersInfo").addDocument(data: dataToSave) { (error) in
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
