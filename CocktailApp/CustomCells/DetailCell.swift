//
//  detailCell.swift
//  CocktailApp
//
//  Created by Daniel Bennett on 2/12/23.
//

import UIKit

class DetailCell: UITableViewCell {
    
    var cocktailToDisplay:Cocktail?
    var row:Int?
    

    @IBOutlet weak var detailLabel: UILabel!
    
    func displayDetails(_ cocktail:Cocktail, _ indexPath:IndexPath, _ measurementToDisplay:[String?], _ ingredientsToDisplay: [String?]) {
        
        // Keep a reference to cocktail
        cocktailToDisplay = cocktail
        
        if indexPath.section == 0 {
            detailLabel.text = measurementToDisplay[indexPath.row]! + ingredientsToDisplay[indexPath.row]!
        }
        else {
            detailLabel.text = cocktail.strInstructions
        }
        
        
        
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
