//
//  HomeViewController.swift
//  MitchellAntoine_DankTank
//
//  Created by Antoine Mitchell on 4/13/22.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var strains = [Strains]()
    var loggedIn = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        // Get the path to our EmployeeData.json file
        
        if let path = Bundle.main.path(forResource: "Strains", ofType: ".json") {
            
            // Create URL with path
            let url = URL(fileURLWithPath: path)
            
            do {
                // Create a Data object from file's URL
                // After this line execcutes, our file is in binary format inside the "data" constant
                let data = try Data.init(contentsOf: url)
                
                // Create a Json Object from the binary Data file.
                // Cast it as an array of Any type objects.
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                // At this point an array of Any objects that represents our Json data from our file
                // Now parse through the jsonObj and start instantiating out Customer objects.
                
                Parse(jsonObject: jsonObj)
                
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 37
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_ID", for: indexPath) as! CollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let theCell = cell as? CollectionViewCell
        
        theCell?.SetupCell(strainNam: strains[indexPath.row].nameOf, imageString: strains[indexPath.row].imageUrl)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    func Parse(jsonObject: [Any]? ) {
        
        guard let json = jsonObject
        else {print("Parse Failed to unwrap the Optional"); return}
        
        // Loop through first level objects
        for firstLevelItem in json {
            
            // Try to convert first level objects to a [String: Any]
            guard let object = firstLevelItem as? [String: Any],
                    // Get the property value of the current object
                  let name = object["name"] as? String,
                  let info = object["discription"] as? String,
                  let effects = object["effect"] as? String,
                  let imageUrl = object["image"] as? String,
                  let condition = object["helps"] as? String,
                  let type = object["type"] as? String
                  
        // If anything in the gaurd fail, immediatley continue to the next iteration of the loop
        else{ return }
            
            strains.append(Strains(name: name, info: info, effects: effects, imageUrl: imageUrl, condition: condition, type: type))
                  
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        
        // Pass the selected object to the new view controller.
    }
    
    
}
