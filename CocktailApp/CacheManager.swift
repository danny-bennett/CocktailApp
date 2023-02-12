//
//  CacheManager.swift
//  CocktailApp
//
//  Created by Daniel Bennett on 2/12/23.
//

import Foundation

class CacheManager {
    
    static var imageDictionary = [String:Data]()
    
    static func saveData(_ url:String, _ imageData:Data) {
        
        // Save the image data and image url
        imageDictionary[url] = imageData
    }
    
    static func retrieveData(_ url:String) -> Data? {
        
        // Return saved image data or nil 
        return imageDictionary[url]
    }
}
