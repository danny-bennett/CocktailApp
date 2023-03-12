//
//  CacheManager.swift
//  CocktailApp
//
//  Created by Daniel Bennett on 2/12/23.
//

import Foundation

class CacheManager {
    
    static var imageDictionary = [String:Data]()
    static var cocktailDictionary = [String:Cocktail]()
    static var cache = NSCache<NSString, NSData>()
    
    static func saveData(_ url:String, _ imageData:Data) {
        
        // Save the image data and image url
        cache.setObject(imageData as NSData, forKey: url as NSString)
    }
    
    static func retrieveData(_ url:String) -> Data? {
        
        // Return saved image data or nil 
        return cache.object(forKey: url as NSString) as Data? 
    }
    
    static func saveCocktail(_ id:String, _ cocktail:Cocktail) {
        
        cocktailDictionary[id] = cocktail
        
    }
    
    static func retrieveCocktail(_ id:String) -> Cocktail {
        
        return cocktailDictionary[id]!
    }
}
