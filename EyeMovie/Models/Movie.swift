//
//  Movie.swift
//  EyeMovie
//
//  Created by Marcu Bale on 02.08.2022.
//

import Foundation

struct MoviesData: Codable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Codable {
    init(id: Int, title: String?, imagePath: String?, landscapePath: String?, release_date: String?, genres: [String]?, overview: String?) {
        self.id = id
        self.title = title
        self.imagePath = imagePath
        self.landscapePath = landscapePath
        self.release_date = release_date
        self.genres = genres
        self.overview = overview
    }
    
    
//    init(id: Int, title: String?, imagePath: String?, landscapePath: String?, release_date: String?) {
//        self.id = id
//        self.title = title
//        self.imagePath = imagePath
//        self.landscapePath = landscapePath
//        self.release_date = release_date
//    }
    
//    init(id: Int, title: String?, imagePath: String?, landscapePath: String?) {
//        self.id = id
//        self.title = title
//        self.imagePath = imagePath
//        self.landscapePath = landscapePath
//    }
    
    
    
    let id: Int
    let title: String?
    let imagePath: String?
    let landscapePath: String?
    let release_date: String?
    let genres: [String]?
    let overview: String?
    
  
//    init(id: Int, title: String, imagePath: String, landscapePath: String) {
//        self.title = title
//        self.imagePath = imagePath
//        self.landscapePath = landscapePath
//    }
    
    private enum CodingKeys: String, CodingKey{
        case id, release_date, genres, overview
        case title = "title"
        case imagePath = "poster_path"
        case landscapePath = "backdrop_path"
    }
    
}

struct MovieSection {
    let title: String
    var movies = [Movie]()
    let isLandscape: Bool
}

class MovieData {
    var popularSection: MovieSection
    var upcomingSection: MovieSection
    var topRatedSection: MovieSection
    
    init(
        popularSection: MovieSection = .init(title: "Popular Movies", isLandscape: false),
        upcomingSection: MovieSection = .init(title: "Upcoming Movies", isLandscape: true),
        topRatedSection: MovieSection = .init(title: "Top Rated Movies", isLandscape: true)
    ) {
        self.popularSection = popularSection
        self.upcomingSection = upcomingSection
        self.topRatedSection = topRatedSection
    }
    
    var sections: [MovieSection] {
        [popularSection, upcomingSection, topRatedSection]
    }
    
    func setPopular(movies: [Movie]){
        popularSection.movies = movies
    }
    
    func setUpcoming(movies: [Movie]){
        upcomingSection.movies = movies
    }
    
    func setTopRated(movies: [Movie]){
        topRatedSection.movies = movies
    }
}

//extension UserDefaults {
//    var movies: [Movie] {
//        get {
//            guard let data = UserDefaults.standard.data(forKey: "movies") else {
//                return []
//            }
//            return (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as? [Movie] ?? []
//        }
//
//        set {
//            UserDefaults.standard.set(try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false), forKey: "movies")
//        }
//    }
//}

