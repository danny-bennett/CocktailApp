//
//  SearchViewController.swift
//  CocktailApp
//
//  Created by Daniel Bennett on 2/9/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    var model = CocktailModel()
    var cocktails = [Cocktail]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set self as delegate for cocktailModel
        model.delegate = self
        model.getCocktails("s=")
        
        // Set self as data source and delegate for table view
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Detect the indexpath the user selected
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            // The user hasn't selected anything
            return
        }
        
        // Get the cocktail the user tapped on
        let cocktail = cocktails[indexPath!.row]
        
        // Get a reference to the detail view controller
        let detailVC = segue.destination as! detailViewController
        
        // Pass information to detail view controller
        detailVC.cocktail = cocktail
    }
    
        
    @IBAction func searchButton(_ sender: Any) {
        
        // TODO: fix this force unwrap
        let searchCriteria:String = searchTextField.text!
        
        // Change spaces in searchTextField to underscores
        let formattedSearchCriteria = searchCriteria.replacingOccurrences(of: " ", with: "_")
        
        // TODO: Create a function to trim whitespace from string and replace " " with "_" as done above.
        
        // Get the cocktails from the model
        model.getCocktails("s=" + formattedSearchCriteria)
    }
    
}

extension SearchViewController: CocktailModelProtocol {
    
    // MARK: - Article Model Protocol Methods
    func cocktailsRetrieved(_ cocktails: [Cocktail]) {
        
        // Set the cocktails property of the view controller to the cocktails passed back from the model
        self.cocktails = cocktails
        
        // Reload the table view
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let searchCell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        
        // Customize it
        searchCell.displayCocktail(cocktails[indexPath.row])
        
        // Return the cell
        return searchCell
    }
}
