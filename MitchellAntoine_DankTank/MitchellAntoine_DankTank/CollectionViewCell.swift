//
//  CollectionViewCell.swift
//  MitchellAntoine_DankTank
//
//  Created by Antoine Mitchell on 4/17/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var strainNam: UILabel!
    @IBOutlet weak var strainImage: UIImageView!
    
    
    func SetupCell(strainNam: String, imageString: String) {
        
        self.strainNam.text = strainNam
        
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
}
