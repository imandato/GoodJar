//
//  SettingsViewController.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/4/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseUI
import GoogleSignIn
import SDWebImage

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var authUI: FUIAuth!
    var goodJarUsers: GoodJarUsers!
    var goodJarUser: GoodJarUser! {
        didSet{
            guard let url = URL(string: goodJarUser.photoURL ) else{
                profilePhoto.image = UIImage(named: "profileStock")
                print("ERROR: cannot convert photoURL String to a URL")
                return
            }
            profilePhoto.sd_setImage(with: url, placeholderImage: UIImage(named: "profileStock"))
        }
    }
    
    
    //    var email: String!
    
    
    let menu = ["Name", "Username", "Email",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        
        
        goodJarUsers = GoodJarUsers()
        

        
        //        loadLabels()
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Georgia", size: 25.0)!]
        
        profilePhoto!.isHidden = true
        userName!.isHidden = true
        userHandle!.isHidden = true
        tableView!.isHidden = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.toolbar.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = profilePhoto.bounds.width / 2
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signIn()
    }
    
    // Nothing should change unless you add different kinds of authentication.
    func signIn() {
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
        ]
        let currentUser = authUI.auth?.currentUser
        
        if authUI.auth?.currentUser == nil {
            self.authUI?.providers = providers
            present(authUI.authViewController(), animated: true, completion: nil)
        } else {
            profilePhoto!.isHidden = false
            userName!.isHidden = false
            userName.text = currentUser?.email
            userHandle!.isHidden = false
            userHandle.text = currentUser?.displayName
            navigationController?.navigationBar.isHidden = false
            navigationController?.toolbar.isHidden = false
            goodJarUser = GoodJarUser(user: currentUser!)
            goodJarUser.saveIfNewUser()
            //            email = authUI.auth?.currentUser?.email
            //print()
            
        }
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        do {
            try authUI!.signOut()
            print("^^^ Successfully signed out!")
            profilePhoto!.isHidden = true
            userName!.isHidden = true
            userHandle!.isHidden = true
            tableView!.isHidden = true
            navigationController?.navigationBar.isHidden = true
            navigationController?.toolbar.isHidden = true
            signIn()
        } catch {
            profilePhoto!.isHidden = true
            userName!.isHidden = true
            userHandle!.isHidden = true
            tableView!.isHidden = true
            navigationController?.navigationBar.isHidden = true
            navigationController?.toolbar.isHidden = true
            print("*** ERROR: Couldn't sign out")
        }
        
    }
    
    
    @IBAction func myJarPressed(_ sender: Any) {
        performSegue(withIdentifier: "showJar", sender: sender)
    }
    
    
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let segueIdentifier: String
    //        switch indexPath.row {
    //        case 0: //For "one"
    //             segueIdentifier = "showEditProfile"
    //        case 1: //For "two"
    //             segueIdentifier = "showFriendRequests"
    //        case 2:
    //            segueIdentifier = "showNotifications"
    //        default:
    //            segueIdentifier = "showPrivacy"
    //        }
    //        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    //    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showJar" {
//            let destination = segue.destination as! JarViewController
//            destination.userId = goodJarUser.documentID
//        }
//    }
    
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = menu[indexPath.row]
        if indexPath.row == 3 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        return cell
    }
    
    
}

extension MainViewController: FUIAuthDelegate {
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if let user = user {
            // Assumes data will be isplayed in a tableView that was hidden until login was verified so unauthorized users can't see data.
            profilePhoto!.isHidden = false
            userName!.isHidden = false
            userHandle!.isHidden = false
            tableView!.isHidden = false
            navigationController?.navigationBar.isHidden = false
            navigationController?.toolbar.isHidden = false
            print("^^^ We signed in with the user \(user.email ?? "unknown e-mail")")
            
            
            
        }
    }
}



