//
//  FavoritesMovies.swift
//  EyeMovie
//
//  Created by Marcu Bale on 12.08.2022.
//

import Foundation

class FavoritesMovies {
    
    static let instance = FavoritesMovies()
    
    private init(){
        
    }
    
    var listFavoritesMovies = [Movie]()
}
