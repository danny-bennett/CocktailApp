//
//  SearchTableViewCell.swift
//  CocktailApp
//
//  Created by Daniel Bennett on 2/10/23.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cocktailImageView: UIImageView!
    
    @IBOutlet weak var cocktailNameLabel: UILabel!
    
    @IBOutlet weak var cocktailCategoryLabel: UILabel!
    
    var cocktailToDisplay:Cocktail?
    
    func displayCocktail(_ cocktail:Cocktail) {
        
        // Keep a reference to the cocktail
        cocktailToDisplay = cocktail
        
        // Set the cocktail name label
        cocktailNameLabel.text = cocktailToDisplay!.strDrink
        
        // Set the cocktail category label
        cocktailCategoryLabel.text = cocktailToDisplay!.strCategory
        
        // Download and display the cocktail image
        // Check that the cocktail has an image
        guard cocktailToDisplay!.strDrinkThumb != nil else {
            return
        }
        
        // Create url string
        let urlString = cocktailToDisplay!.strDrinkThumb!
        
        // Check the cacheManager before downloading image data
        if let imageData = CacheManager.retrieveData(urlString) {
            
            // There is image data. Set the imageView and return
            self.cocktailImageView.image = UIImage(data: imageData)
            return
            
        }
        
        // Create the url
        let url = URL(string: urlString)
        
        // Check that the url isn't nil
        guard url != nil else {
            print("Couldn't create url object.")
            return
        }
        
        // Get a URLSession
        let session = URLSession.shared
        
        // Create a datatask
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            // Check that there is data and no errors
            if data != nil && error == nil {
                
                // Save data to cacheManager
                CacheManager.saveData(urlString, data!)
                
                if self.cocktailToDisplay!.strDrinkThumb == urlString {
                    
                    DispatchQueue.main.async {
                        
                        // Display the image data in the image view
                        self.cocktailImageView.image = UIImage(data: data!)
                    }
                }
            }
        }
        
        // Kick off the datatask
        dataTask.resume()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
