//
//  SignUpViewController.swift
//  IOSProject
//
//  Created by Ryan Stich on 2021-03-12.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hide()
        signUpButton.layer.cornerRadius = 7.5
        backButton.layer.cornerRadius = 7.5
        signUpButton.layer.borderWidth = 1.5
        signUpButton.layer.borderColor = UIColor.white.cgColor
        backButton.layer.borderWidth = 1.5
        backButton.layer.borderColor = UIColor.white.cgColor
        
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        lastNameTextField.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        // Do any additional setup after loading the view.
    }
    
    func hide() {
        errorLabel.alpha = 0
    }
    
    
    func validateFields() -> String? {
        
        if firstNameTextField.text == "" ||
            lastNameTextField.text == "" ||
            emailTextField.text == "" ||
            passwordTextField.text == ""
            {
            return "Woah slow down there! Make sure all text fields have been filled in."
        }
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        // Process text fields
        
        // if something went wrong -> show error message
        
        let error = validateFields()
        
        //Why a nested function?
        func uhOh (message: String) {
            
            errorLabel.text = message
            errorLabel.alpha = 1
        }
        //Guard statement?
        if error != nil {
          uhOh(message: error!)
        }
        else {
            
            // create error free variables
            
            let firstname = firstNameTextField.text!
            
            let lastname = lastNameTextField.text!
            
            let email = emailTextField.text!
            
            let password = passwordTextField.text!
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //What other checks happen here?
                if err != nil {
                    uhOh(message: "Its not us, its you. please make sure your form is filled out correctly and submit again.")
                }
                else {
                    
                    let db = Firestore.firestore()
                    
                    db.collection("User").addDocument(data: ["firstname": firstname, "lastname": lastname, "uid": result!.user.uid]) { (error) in
                        //Will this ever be seen?
                        if error != nil {
                            uhOh(message: "Something went wrong")
                        }
                    }
                
                    self.goHome()
                }
                
            }
        }
    }
    
    //Better handled via segue?
    func goHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Boards.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
}
