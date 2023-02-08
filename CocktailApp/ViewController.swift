//
//  ViewController.swift
//  CocktailApp
//
//  Created by Daniel Bennett on 2/7/23.
//

import UIKit

class ViewController: UIViewController {
    
    var model = CocktailModel()
    var cocktails = [Cocktail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the cocktails from the model
        model.delegate = self
        model.getCocktails()
       
    }
}

extension ViewController: CocktailModelProtocol {
    
    // MARK: - Article Model Protocol Methods
    
    func cocktailsRetrieved(_ cocktails: [Cocktail]) {
        
        // Set the cocktails property of the view controller to the cocktails passed back from the model
        self.cocktails = cocktails
    }
}

