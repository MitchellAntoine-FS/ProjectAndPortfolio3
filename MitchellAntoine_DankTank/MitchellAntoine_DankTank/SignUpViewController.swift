//
//  SignUpViewController.swift
//  MitchellAntoine_DankTank
//
//  Created by Antoine Mitchell on 4/23/22.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorTextField: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide error label
        errorTextField.alpha = 0
        
        // Style the textFileds
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    }

    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == " " ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == " " ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == " " ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == " " {
            
            return "Please fill in all fileds"
        }
        
        // Check if password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password is not secure
            return "Make sure your password is at least 8 characters, contains a special character and a number"
        }
        
        return nil
    }
    
    

    @IBAction func signUpButton(_ sender: UIButton) {
        
        // Validate the fields
//        let error = validateFields()
        
        // Create clean versons of the data
//        let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
//        let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        // Cteate the user
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            
            // Check for errors
            if err != nil {
            self.showError("Error creating user")
        }
        else {
            // User was created successfully, store user info
//            let db = Firestore.firestore()
//
//            db.collection("users").addDocument(data: ["firstName":firstName, "lastName":lastName, "uid": result!.user.uid]) { (error) in
//
//                if error != nil {
//                    self.showError("Error saving user data")
//                }
//            }
            // Transition the home screen
            self.goToHomeView()
        }
        }
        
        
    }
    
    func showError(_ message: String) {
        errorTextField.text = message
        errorTextField.alpha = 1
    }
    
    func goToHomeView() {
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
