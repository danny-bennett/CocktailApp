//
//  ViewController.swift
//  CocktailApp
//
//  Created by Daniel Bennett on 2/7/23.
//

import UIKit

class PopularViewController: UIViewController {
    
    var model = CocktailModel()
    var cocktails = [Cocktail]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the cocktails from the model
        model.delegate = self
        model.getCocktails("popular.php")
        
        // Set the dataSource and delegate for the tableView as self
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Detect the indexPath the user selected
        let indexPath = tableView.indexPathForSelectedRow
        
        // Verify that the user has selected a row
        guard indexPath != nil else {
            // No row selected
            return
        }
        
        // Get the cocktail the user tapped on
        let cocktail = cocktails[indexPath!.row]
        
        // Get a reference to the detailViewController
        let detailVC = segue.destination as! DetailViewController
        
        // Pass information to detail view controller
        detailVC.cocktail = cocktail
    }
}

extension PopularViewController: CocktailModelProtocol {
    
    // MARK: - Article Model Protocol Methods
    
    func cocktailsRetrieved(_ cocktails: [Cocktail]) {
        
        // Set the cocktails property of the view controller to the cocktails passed back from the model
        self.cocktails = cocktails
        
        tableView.reloadData()
    }
}

extension PopularViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table View Protocol Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cocktails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCell
        
        // Customize the cell
        cell.displayCocktail(cocktails[indexPath.row])
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect row to get rid of highlight
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

