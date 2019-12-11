//
//  JarViewController.swift
//  GoodJar
//
//  Created by Ivelisse Mandato on 12/4/19.
//  Copyright © 2019 Ivelisse Mandato. All rights reserved.
//

import UIKit

class JarViewController: UIViewController {
    
    @IBOutlet weak var jarImageButton: UIButton!
    @IBOutlet weak var messagePopUp: UIView!
            
    var affirmations: Affirmations!
    var affirmationText = ""
    var affirmation: Affirmation!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        affirmations = Affirmations()
        affirmation = Affirmation()
        
//        affirmations.loadData {
//            print(self.affirmations.affirmationArray[0])
//            self.affirmation = self.affirmations.affirmationArray[0].affirmation
//            print(self.affirmation)
            self.jarImageButton.isHidden = false
        
//        }
//
   
        
    }
    
    
    @IBAction func jarBarButtonPressed(_ sender: Any) {
        
        affirmations.loadData {
            print(self.affirmations.affirmationArray[0].affirmation)
            self.affirmationText = self.affirmations.affirmationArray[0].affirmation
            
        }
        showAlert(title: "Affirmation", message: self.affirmationText)
//
    }
    
    func showAlert(title: String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func exitBarButtonPressed(_ sender: Any) {
        leaveViewController()
    }
}
