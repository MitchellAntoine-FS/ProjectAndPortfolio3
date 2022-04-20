//
//  DetailsViewController.swift
//  MitchellAntoine_DankTank
//
//  Created by Antoine Mitchell on 4/19/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var strain: Strains!
    
    @IBOutlet weak var strainImage: UIImageView!
    @IBOutlet weak var strainName: UILabel!
    @IBOutlet weak var strainInfo: UITextView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var effectsLabel: UILabel!
    @IBOutlet weak var saveToProfileLable: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func saveToProfile(_ sender: Any) {
    }
    
    
    

}
