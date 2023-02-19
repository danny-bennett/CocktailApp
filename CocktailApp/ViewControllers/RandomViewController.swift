//
//  RandomViewController.swift
//  CocktailApp
//
//  Created by Daniel Bennett on 2/9/23.
//

import UIKit

class RandomViewController: UIViewController {

    @IBOutlet weak var randomButton: UIButton!
    
    var model = CocktailModel()
    var cocktail = [Cocktail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set self as delegate for cocktailModel
        model.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        model.getCocktails("random.php")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get a reference to the detail view controller
        let detailVC = segue.destination as! DetailViewController
        
        // Pass information to detail view controller
        detailVC.cocktail = cocktail[0]
    }
    
    @IBAction func randomButton(_ sender: Any) {
        
        
    }
    
    func getImageData(_ urlString:String) {
        
        // Keep a reference to the cocktail
        let cocktail = self.cocktail[0]
        
        // Download and display the cocktail image
        // Check that the cocktail has an image
        guard cocktail.strDrinkThumb != nil else {
            // No value for strDrinkThumb
            return
        }
        
        // Create a url string
        let urlString = cocktail.strDrinkThumb
        
        // Create the url
        let url = URL(string: urlString!)
        
        // Check that the url isn't nil
        guard url != nil else {
            // url is nil
            print("Couln't create url object")
            return
        }
        
        // Get a url session
        let session = URLSession.shared
        
        // Create a dataTask
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            // Check that there is data and no errors
            if data != nil && error == nil {
                
                // Save to cache manager
                CacheManager.saveData(urlString!, data!)
                
            }
        }
        dataTask.resume()
        
    }
    
}

extension RandomViewController: CocktailModelProtocol {
    
    func cocktailsRetrieved(_ cocktails: [Cocktail]) {
        
        // Set the cocktail property of the view controller to the cocktails passed back from the model
        self.cocktail = cocktails
        
        if cocktails[0].strDrinkThumb != nil {
            getImageData(self.cocktail[0].strDrinkThumb!)
        }
        else {
            print("Error getting image data.")
        }
        
    }
}


