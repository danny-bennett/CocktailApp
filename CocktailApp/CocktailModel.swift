//
//  CocktailModel.swift
//  CocktailApp
//
//  Created by Daniel Bennett on 2/7/23.
//

import Foundation

protocol CocktailModelProtocol {
    
    func cocktailsRetrieved(_ cocktails:[Cocktail])
}

class CocktailModel {
    
    var delegate:CocktailModelProtocol?
    
    func getCocktails() {
        
        // Send request to the API
        // Create a string URL
        let stringUrl = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"
        
        // Create a URL object
        let url = URL(string: stringUrl)
        
        // Check that it isn't nil
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        
        // Get the URL Session
        let session = URLSession.shared
        
        // Create the data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            // Check that there are no errors and that there's data
            if error == nil && data != nil {
                
                // Attempt to parse the JSON
                let decoder = JSONDecoder()
                
                do {
                    
                    // Parse the JSON into CocktailService
                    let cocktailService = try decoder.decode(CocktailService.self, from: data!)
                    
                    // Get the cocktails
                    let cocktails = cocktailService.drinks!
                    
                    // Pass it back the view controller in the main thread
                    DispatchQueue.main.async {
                        self.delegate?.cocktailsRetrieved(cocktails)
                    }
                }
                catch {
                    
                    print("Error parsing the JSON")
                } 
            }
        }
        
        // Start the data task
        dataTask.resume()
    }
}
