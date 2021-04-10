//
//  LogInViewController.swift
//  IOSProject
//
//  Created by Ryan Stich on 2021-03-12.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        loginButton.layer.cornerRadius = 7.5
        backButton.layer.cornerRadius = 7.5
        loginButton.layer.borderWidth = 1.5
        loginButton.layer.borderColor = UIColor.white.cgColor
        backButton.layer.borderWidth = 1.5
        backButton.layer.borderColor = UIColor.white.cgColor

        hide()
        // Do any additional setup after loading the view.
    }
    
    func hide() {
        errorLabel.alpha = 0
    }
    

    
    @IBAction func loginTapped(_ sender: Any) {
        
        // Validate text fields
        
        func validateFields() -> String? {
            
                if emailTextField.text == "" ||
                    passwordTextField.text == "" {
            
                return "Error within text fields."
        }
            return nil
        }
        
        //Sign in user
        
        let email =  emailTextField.text!
        
        let password = passwordTextField.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if err != nil {
                self.errorLabel.text = "ERROR!"
                self.errorLabel.alpha = 1
            }
            
            else {
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Boards.Storyboard.homeViewController) as? HomeViewController
                  
                self.view.window?.rootViewController = homeViewController
                  
                self.view.window?.makeKeyAndVisible()
            }
        }
        
    }
}
