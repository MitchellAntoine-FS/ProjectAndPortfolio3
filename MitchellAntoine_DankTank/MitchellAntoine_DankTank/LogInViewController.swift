//
//  LogInViewController.swift
//  MitchellAntoine_DankTank
//
//  Created by Antoine Mitchell on 4/23/22.
//

import UIKit
import FirebaseAuth
import Firebase


class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide error label
        errorLabel.alpha = 0
        
        // Style the textFileds
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(logInButton)
        
    }

    @IBAction func logInButton(_ sender: UIButton) {
        
        // Validate the text fields
        
        //
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Sign in the user
        Auth.auth().signIn(withEmail: email, password: password) { (results, error) in
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                
                self.goToHomeView()

            }
        }
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if self.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == " " ||
            self.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == " " {
            
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
    
    func goToHomeView() {
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if let navController = mainStoryBoard.instantiateViewController(withIdentifier: "NavVC") as? UINavigationController {

            present(navController, animated: true, completion: nil )
        }
    }
}
