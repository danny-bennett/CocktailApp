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
    var filteredCocktails = [Cocktail]()
    var filtered = false
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set self as delegate for cocktailModel
        model.delegate = self
        model.getCocktails("search.php?s=")
        
        // Set self as data source and delegate for table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set self as delegate for searchTextField
        searchTextField.delegate = self
        
        // Dismiss keyboard by tapping anywhere on screen
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Detect the indexpath the user selected
        let indexPath = tableView.indexPathForSelectedRow
        var cocktail: Cocktail
        
        guard indexPath != nil else {
            // The user hasn't selected anything
            return
        }
        
        
        // Get the cocktail the user tapped on
        if !filteredCocktails.isEmpty {
            cocktail = filteredCocktails[indexPath!.row]
        }
        else {
            
            cocktail = cocktails[indexPath!.row]
        }
        
        
        // Get a reference to the detail view controller
        let detailVC = segue.destination as! DetailViewController
        
        // Pass information to detail view controller
        detailVC.cocktail = cocktail
    }
    
    
    func filterText(_ query: String!) {
        
        filteredCocktails.removeAll()
        for cocktail in cocktails {
            if cocktail.strDrink!.lowercased().starts(with: query!.lowercased()) {
                filteredCocktails.append(cocktail)
            }
        }
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss keyboard when "Enter" is pressed
        textField.resignFirstResponder()
    }
}

extension SearchViewController: CocktailModelProtocol {
    
    // MARK: - Article Model Protocol Methods
    func cocktailsRetrieved(_ cocktails: [Cocktail]) {
        
        // Set the cocktails property of the view controller to the cocktails passed back from the model
        self.cocktails = cocktails
        
        // Reload the table view
        tableView.reloadData()
        filtered = true
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // If filteredCocktails is not empty, return its count.
        if !filteredCocktails.isEmpty {
            return filteredCocktails.count
        }
        else {
            return filtered ? 0 : cocktails.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let searchCell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCell
        
        // Customize it
        if !filteredCocktails.isEmpty {
            searchCell.displayCocktail(filteredCocktails[indexPath.row])
        }
        else {
            searchCell.displayCocktail(cocktails[indexPath.row])
        }
       
        // Return the cell
        return searchCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect row to get rid of highlight
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        filterText(textField.text)
    }
}


