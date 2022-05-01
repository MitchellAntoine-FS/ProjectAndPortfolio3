//
//  SearchViewController.swift
//  MitchellAntoine_DankTank
//
//  Created by Antoine Mitchell on 4/25/22.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var strainsArray = [Strains]()
    var filteredArray = [Strains]()
    
    // Passing nil to tell the search controller to use the TableViewController to display the results
    var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        // Setup search controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        
        // To receive updates to search here in this TableViewController
        searchController.searchResultsUpdater = self
        
        // Setup searchBar of search controller
        searchController.searchBar.scopeButtonTitles = ["All", "Sativa", "Indica", "Hybrid"]
        searchController.searchBar.delegate = self
        searchController.searchBar.backgroundColor = .white
        
        navigationItem.searchController = searchController
        
        filteredArray = strainsArray
        
        // Get the path to our Strains.json file
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strainsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_ID1", for: indexPath)
        
        cell.textLabel?.text = strainsArray[indexPath.row].nameOf
        
        let imageString = strainsArray[indexPath.row].imageUrl
        
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
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // Get the text that the user wants to search for
        let searchText = searchController.searchBar.text
        
        //Get the scope button tittle that the user selected
        let selectedScope = searchController.searchBar.selectedScopeButtonIndex
        let allScopeTitles = searchController.searchBar.scopeButtonTitles!
        let scopeTitle = allScopeTitles[selectedScope]
        
        //Filter data here
        filteredArray = strainsArray
        
        //If the user types anything into the search field, then filter based on that entry
        if searchText != "" {
            
             filteredArray = filteredArray.filter({ (strain) -> Bool in
                 return strain.nameOf.lowercased().range(of: searchText!.lowercased()) != nil
             })
        }
        
        //Filter again based on scope
        if scopeTitle != "All" {
            filteredArray = filteredArray.filter({
                
                // Using $0 to represent the current element instead of naming the parameter.
                $0.typeOf.range(of: scopeTitle) != nil
            })
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
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
            
            strainsArray.append(Strains(name: name, info: info, effects: effects, imageUrl: imageUrl, condition: condition, type: type))
                  
        }
        
    }

    @IBAction func homeButton(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func profileButton(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            // Get the new view controller using segue.destination.
            if let destination = segue.destination as? DetailsViewController {
            // Pass the selected object to the new view controller.
                destination.strain = strainsArray[indexPath.row]
            }
            
        }
    }

}
