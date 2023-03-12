//
//  LiquorCell.swift
//  CocktailApp
//
//  Created by Daniel Bennett on 2/25/23.
//

import UIKit

class LiquorCell: UITableViewCell {
    
    @IBOutlet weak var liquorImageView: UIImageView!
    
    @IBOutlet weak var liquorName: UILabel!
    
    func displayLiquor(_ liquor: String) {
        
        // Set liquor name
        liquorName.text = liquor
        
        // Download and display the liquor image
        // Create a url string
        let urlString = "https://www.thecocktaildb.com/images/ingredients/\(liquor)-Medium.png"
        
        // Check the cacheManager before downloading the image data
        if let imageData = CacheManager.retrieveData(urlString) {
            
            // Image data was found in cache, set liquor image view
            liquorImageView.image = UIImage(data: imageData)
            return
        }
        
        // Create the url
        let url = URL(string: urlString)
        
        // Check that the url isn't nil
        guard url != nil else {
            print("Couldn't create url object.")
            return
        }
        
        // Get a url session
        let session = URLSession.shared
        
        // Create a dataTask
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            // Check that there is data and there are no errors
            if data != nil && error == nil {
                
                // Save to cacheManager
                CacheManager.saveData(urlString, data!)
                
                if "https://www.thecocktaildb.com/images/ingredients/\(liquor)-Medium.png" == urlString {
                    
                    DispatchQueue.main.async {
                        
                        // Display the image
                        self.liquorImageView.image = UIImage(data: data!)
                    }
                }
            }
        }
        dataTask.resume()
        
    }
    
    override func prepareForReuse() {
        liquorImageView.image = nil
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
