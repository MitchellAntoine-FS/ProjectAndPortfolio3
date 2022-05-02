//
//  ProfileViewController.swift
//  MitchellAntoine_DankTank
//
//  Created by Antoine Mitchell on 4/25/22.
//


import Photos
import PhotosUI
import UIKit

class ProfileViewController: UIViewController, PHPickerViewControllerDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var strains = [Strains]()
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        loadSavedData()
        
    }
    
    func loadSavedData() {

        // Load saved Data
        guard let savedImage = UserDefaults.standard.string(forKey: "imageUrl"),
        let savedName = UserDefaults.standard.string(forKey: "name")
        else {return}
        
        strains.append(Strains(name: savedName, info: "", effects: "", imageUrl: savedImage, condition: "", type: ""))
           
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strains.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        
        cell.textLabel?.text = strains[indexPath.row].nameOf
        let imageString = strains[indexPath.row].imageUrl
        
        do {

        if imageString.contains("http"),
            let url = URL(string: imageString),
                var urlComp = URLComponents(url: url, resolvingAgainstBaseURL: false)
        {
            // Change to secure server.
            urlComp.scheme = "https"

                if let secureURL = urlComp.url {

                    let data = try Data.init(contentsOf: secureURL)
                    cell.imageView?.image = UIImage(data: data)
                }
            }
        }
        catch {
            print(error.localizedDescription)
            assertionFailure();
        }
        
        return cell
    }
    
    @IBAction func selectPhotoButton(_ sender: UIButton) {
        
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = .images
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated: true)

    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in

                guard let image = reading as? UIImage, error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    
                    self.profileImage.image = image
                    
                }
                
            }

        }
    }
    
    @IBAction func homeButton(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    

}
