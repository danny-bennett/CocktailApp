//
//  CocktailViewController.swift
//  CocktailApp
//
//  Created by Daniel Bennett on 2/9/23.
//

import UIKit

class LiquorViewController: UIViewController {
    
    var model = CocktailModel()
    var cocktails = [Cocktail]()
    var liquors = ["Vodka", "Rum", "Whiskey", "Gin", "Tequila", "Brandy"]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the tableView's delegate and datasourse as self
        tableView.delegate = self
        tableView.dataSource = self
        
        model.delegate = self
        model.getCocktails("search.php?s=")
        
        // Set back button to white minimal arrow
        navigationItem.backButtonDisplayMode = .minimal
        navigationController!.navigationBar.tintColor = UIColor.label
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Detect the indexpath the user selected
        let indexpath = tableView.indexPathForSelectedRow
        var liquor: String
        
        guard indexpath != nil else {
            // User hasn't selected anything
            return
        }
        
        // Get the liquor the user tapped on
        liquor = liquors[indexpath!.row]
        
        // Get a reference to the detail view controller
        let detailVC = segue.destination as! LiquorDetailViewController
        
        // Pass liquor to the detailVC
        detailVC.selectedLiquor = liquor
        
        
        
    }
}

// MARK: - TableView Protocol Methods
extension LiquorViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liquors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LiquorCell
        
        // Customize the cell
        cell.displayLiquor(liquors[indexPath.row])
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect row to get rid of highlight
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension LiquorViewController: CocktailModelProtocol {
    func cocktailsRetrieved(_ cocktails: [Cocktail]) {
        self.cocktails = cocktails
    }
    
}
