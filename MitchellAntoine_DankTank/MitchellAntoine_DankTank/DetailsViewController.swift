//
//  DetailsViewController.swift
//  MitchellAntoine_DankTank
//
//  Created by Antoine Mitchell on 4/19/22.
//

import UIKit
import FirebaseStorage

class DetailsViewController: UIViewController {
    
    var strain: Strains!
    
    @IBOutlet weak var strainImage: UIImageView!
    @IBOutlet weak var strainName: UILabel!
    @IBOutlet weak var strainInfo: UITextView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var effectsLabel: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
        
    }
    
    func setUI() {
        
        self.strainName.text = strain.nameOf
        self.strainInfo.text = strain.infoOf
        self.typeLabel.text = strain.typeOf
        self.conditionLabel.text = strain.conditionOf
        self.effectsLabel.text = strain.effectsOf
        
        let imageString = strain.imageUrl
        do {

        if imageString.contains("http"),
            let url = URL(string: imageString),
                var urlComp = URLComponents(url: url, resolvingAgainstBaseURL: false)
        {
            // Change to secure server.
            urlComp.scheme = "https"

                if let secureURL = urlComp.url {

                    let data = try Data.init(contentsOf: secureURL)
                    self.strainImage.image = UIImage(data: data)
                }
            }
        }
        catch {
            print(error.localizedDescription)
            assertionFailure();
        }
        
    }
    
    @IBAction func saveToProfile(_ sender: Any) {
        
        UserDefaults.standard.set(strain.imageUrl, forKey: "imageUrl")
        UserDefaults.standard.set(strain.nameOf, forKey: "name")
        
    }
    
    @IBAction func homeButton(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    @IBAction func profileButton(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
}
