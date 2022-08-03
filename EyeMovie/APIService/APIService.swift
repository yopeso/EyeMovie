//
//  APIService.swift
//  EyeMovie
//
//  Created by Marcu Bale on 03.08.2022.
//

import Foundation

class APIService {
    
    //should i use result??
    func getMockData(url: URL, completion: @escaping ([Movie]) -> Void) {
        let movies = [Movie(title: "Movie 1", imagePath: "movie1"), Movie(title: "Movie 2", imagePath: "movie2"), Movie(title: "Movie 3", imagePath: "movie3")]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(movies)
        }
        
    }
    
    func getData(url: URL, completion: @escaping ([Movie]) -> Void) {
        
    }
}
