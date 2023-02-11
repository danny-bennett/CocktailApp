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
