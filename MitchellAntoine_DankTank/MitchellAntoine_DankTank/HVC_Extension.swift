//
//  HomeViewExtion.swift
//  MitchellAntoine_DankTank
//
//  Created by Antoine Mitchell on 4/15/22.
//

import Foundation

extension HomeViewController {
    
    func downloadJson(atURL urlString: String) {
        
        // Create a default configuration
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        if let validURL = URL(string: urlString) {

            let task = session.dataTask(with: validURL, completionHandler: { (opt_data, opt_response, opt_error) in

                //Bail Out on error
                if opt_error != nil { return }

                //Check the response, statusCode, and data
                guard let response = opt_response as? HTTPURLResponse,
                    response.statusCode == 200,
                    let data = opt_data
                    else { return }

                do {
                    //De-Serialize data object
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        
                        guard let object = json["data"] as? [String: Any],
                              //Array of Objects in JSON, Array of Dictionaries in Swift
                              let children = object[""] as? [String:Any]
                                
                              else { assertionFailure(); return
                          }
                        
                        
                        
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
               
            })
            task.resume()
        }
    }
}
