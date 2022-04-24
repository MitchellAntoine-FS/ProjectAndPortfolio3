//
//  ViewController.swift
//  MitchellAntoine_DankTank
//
//  Created by Antoine Mitchell on 4/23/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements() {
        
        // Style the textFileds
        Utilities.styleFilledButton(logInButton)
        Utilities.styleFilledButton(signUpButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signUpButton(_ sender: UIButton) {
        
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        
    }
    
}
