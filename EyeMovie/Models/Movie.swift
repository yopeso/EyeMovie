//
//  Movie.swift
//  EyeMovie
//
//  Created by Marcu Bale on 02.08.2022.
//

import Foundation

struct Movie {
    let title: String
    let imagePath: String
    
    init(title: String, imagePath: String) {
        self.title = title
        self.imagePath = imagePath
    }
}
