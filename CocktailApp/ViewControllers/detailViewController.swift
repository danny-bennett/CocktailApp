//
//  detailViewController.swift
//  CocktailApp
//
//  Created by Daniel Bennett on 2/12/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var cocktail:Cocktail?
    var ingredientsToDisplay = [String?]()
    var measurementToDisplay = [String?]()
    let sectionTitles = ["Ingredients", "Instructions"]
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var cocktailImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateIngredientsAndInstructions()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Set the name label
        nameLabel.text = cocktail!.strDrink
        
        // Set the category label
        categoryLabel.text = cocktail!.strCategory
        
        if let imageData = CacheManager.retrieveData(cocktail!.strDrinkThumb!) {
            
            // There is data, continue
            // Set the image view
            cocktailImageView.image = UIImage(data: imageData)
        }
        
        
    }
    
    func populateIngredientsAndInstructions() {
        
        // Verify cocktail is not nil 
        guard cocktail != nil else {
            return
        }
        
        // Populate the ingredientsToDipsay and instructionsToDisplay Arrays
        ingredientsToDisplay.append(cocktail!.strIngredient1)
        ingredientsToDisplay.append(cocktail!.strIngredient2)
        ingredientsToDisplay.append(cocktail!.strIngredient3)
        ingredientsToDisplay.append(cocktail!.strIngredient4)
        ingredientsToDisplay.append(cocktail!.strIngredient5)
        ingredientsToDisplay.append(cocktail!.strIngredient6)
        ingredientsToDisplay.append(cocktail!.strIngredient7)
        ingredientsToDisplay.append(cocktail!.strIngredient8)
        ingredientsToDisplay.append(cocktail!.strIngredient9)
        ingredientsToDisplay.append(cocktail!.strIngredient10)
        ingredientsToDisplay.append(cocktail!.strIngredient11)
        ingredientsToDisplay.append(cocktail!.strIngredient12)
        ingredientsToDisplay.append(cocktail!.strIngredient13)
        ingredientsToDisplay.append(cocktail!.strIngredient14)
        ingredientsToDisplay.append(cocktail!.strIngredient15)
        
        measurementToDisplay.append(cocktail!.strMeasure1)
        measurementToDisplay.append(cocktail!.strMeasure2)
        measurementToDisplay.append(cocktail!.strMeasure3)
        measurementToDisplay.append(cocktail!.strMeasure4)
        measurementToDisplay.append(cocktail!.strMeasure5)
        measurementToDisplay.append(cocktail!.strMeasure6)
        measurementToDisplay.append(cocktail!.strMeasure7)
        measurementToDisplay.append(cocktail!.strMeasure8)
        measurementToDisplay.append(cocktail!.strMeasure9)
        measurementToDisplay.append(cocktail!.strMeasure10)
        measurementToDisplay.append(cocktail!.strMeasure11)
        measurementToDisplay.append(cocktail!.strMeasure12)
        measurementToDisplay.append(cocktail!.strMeasure13)
        measurementToDisplay.append(cocktail!.strMeasure14)
        measurementToDisplay.append(cocktail!.strMeasure15)
        
        
        // Get rid of any nil values
        //measurementToDisplay = measurementToDisplay.filter { $0 != nil }
        for i in 0..<measurementToDisplay.count {
            if measurementToDisplay[i] == nil {
                measurementToDisplay[i] = ""
            }
        }
        
        ingredientsToDisplay = ingredientsToDisplay.filter { $0 != nil }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return ingredientsToDisplay.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailCell
        
        // Customize the cell
        cell.displayDetails(cocktail!, indexPath, measurementToDisplay, ingredientsToDisplay)
        
        // Return cell
        return cell
    }
}
