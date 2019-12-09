//
//  ViewController.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/1/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseUI
import GoogleSignIn

class ViewController: UIViewController {

    var authUI: FUIAuth!
    var goodJarUser: GoodJarUser!

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var affirmationTextView: UITextView!
    @IBOutlet weak var submitAffirmationButton: UIButton!
    @IBOutlet weak var jarBarButton: UIBarButtonItem!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    
    
    var email: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Georgia", size: 25.0)!]
        
        profilePhoto!.isHidden = true
        affirmationTextView.isHidden = true
        submitAffirmationButton.isHidden = true
        UserNameLabel.isHidden = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.toolbar.isHidden = true
    }
    
    // Be sure to call this from viewDidAppear
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
            profilePhoto.isHidden = false
            affirmationTextView.isHidden = false
            submitAffirmationButton.isHidden = false
            UserNameLabel.isHidden = false
            navigationController?.navigationBar.isHidden = false
            navigationController?.toolbar.isHidden = false
            goodJarUser = GoodJarUser(user: currentUser!)
            goodJarUser.saveIfNewUser()
            email = authUI.auth?.currentUser?.email
            //print()
            
        }
    }

    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        do {
            try authUI!.signOut()
            print("^^^ Successfully signed out!")
            profilePhoto.isHidden = true
            affirmationTextView.isHidden = true
            submitAffirmationButton.isHidden = true
            UserNameLabel.isHidden = true
            navigationController?.navigationBar.isHidden = true
            navigationController?.toolbar.isHidden = true
            signIn()
        } catch {
            profilePhoto.isHidden = true
            affirmationTextView.isHidden = true
            submitAffirmationButton.isHidden = true
            UserNameLabel.isHidden = true
            navigationController?.navigationBar.isHidden = true
            navigationController?.toolbar.isHidden = true
            print("*** ERROR: Couldn't sign out")
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSettings" {
            let destination = segue.destination as! SettingsViewController
            destination.email = email
            print("View: \(email)")
        }
    }
    
    @IBAction func myJarButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showJar", sender: sender)
    }
    
}


extension ViewController: FUIAuthDelegate {
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
            profilePhoto.isHidden = false
            affirmationTextView.isHidden = false
            submitAffirmationButton.isHidden = false
            UserNameLabel.isHidden = false
            navigationController?.navigationBar.isHidden = false
            navigationController?.toolbar.isHidden = false
            print("^^^ We signed in with the user \(user.email ?? "unknown e-mail")")
            
         
            
        }
    }
}

