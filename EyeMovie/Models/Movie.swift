//
//  Movie.swift
//  EyeMovie
//
//  Created by Marcu Bale on 02.08.2022.
//

import Foundation

struct MoviesData: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

class Movie: Decodable {
    let title: String?
    let imagePath: String?
    let landscapePath: String?
  
//  var ceParereArePontaDespreFilm
//    var isLandscape: Bool = false
    
    init(title: String, imagePath: String, landscapePath: String) {
        self.title = title
        self.imagePath = imagePath
        self.landscapePath = landscapePath
    }
    
    private enum CodingKeys: String, CodingKey{
        case title = "title"
        case imagePath = "poster_path"
        case landscapePath = "backdrop_path"
    }
    
//    func makeLandscapeTrue() {
//        self.isLandscape = true
//    }
}
