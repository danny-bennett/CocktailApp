//
//  LiquorDetailViewController.swift
//  CocktailApp
//
//  Created by Daniel Bennett on 2/25/23.
//

import UIKit

class LiquorDetailViewController: UIViewController {
    
    var model = CocktailModel()
    var cocktails = [Cocktail]()
    var cocktailsWithInfo = [Cocktail]()
    var selectedLiquor: String? = nil
    var allCocktails = [Cocktail]()
    
    @IBOutlet weak var liquorLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // Set the delegate and datasource for the tableView as self
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set the delegate for the model to self
        model.delegate = self
        
        // Set the liquor label
        liquorLabel.text = selectedLiquor
        
        model.getCocktails("filter.php?i=\(selectedLiquor ?? "Whiskey")")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Detect the indexpath the user selected
        let indexpath = tableView.indexPathForSelectedRow
        var cocktail: Cocktail
        
        guard indexpath != nil else {
            // User hasn't selected anything
            return
        }
        
        // Get the cocktail the user tapped on
        cocktail = cocktails[indexpath!.row]
        
        // Get a reference to the detail view controller
        let detailVC = segue.destination as! DetailViewController
        
        // Pass coctail to the detailVC
        detailVC.cocktail = cocktail
    }

}

extension LiquorDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchCell
        
        // Customize it
        cell.displayCocktail(cocktails[indexPath.row])
        
        // Return the cell
        return cell
        
    }
}

extension LiquorDetailViewController: CocktailModelProtocol {
    
    func cocktailsRetrieved(_ cocktails: [Cocktail]) {
        
        self.cocktails = cocktails
        
        // Reload the tableView
        tableView.reloadData()
        
        
    }
}

