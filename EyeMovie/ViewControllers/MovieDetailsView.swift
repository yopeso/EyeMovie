//
//  MovieDetailsView.swift
//  EyeMovie
//
//  Created by Marcu Bale on 11.08.2022.
//

import UIKit
import Foundation

class MovieDetailsView: UIViewController {
    private let movie: Movie
    //let imageMovie: UIImageView
    
    //let favoritesList = FavoritesMovies()
    let favControler = FavoriteViewController()
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //let userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = .green
        view.backgroundColor = .white
        
        addMovieDetails()
        addMovieImage()
        addButton()
    }
    
    private func addMovieDetails(){
        title = movie.title
        print(movie.title ?? "")
        
        let labelTitle = UILabel(frame: CGRect(x: 15, y: 250, width: 300, height: 50))
        labelTitle.font = UIFont(name: "verdana", size: 20)
        view.addSubview(labelTitle)
        labelTitle.textAlignment = .left
        
        labelTitle.text = (title)
        
        let labelReleaseDate = UILabel(frame: CGRect(x: 15, y: 270, width: 100, height: 50))
        view.addSubview(labelReleaseDate)
        labelReleaseDate.textAlignment = .left
        
        labelReleaseDate.text = movie.release_date?.components(separatedBy: "-")[0]
        
        let labelGenre = UILabel(frame: CGRect(x: 40, y: 270, width: 100, height: 50))
        view.addSubview(labelGenre)
        labelGenre.textAlignment = .left
        
        labelGenre.text = movie.genres?[1]
        
        print(movie.genres)
        
        let labelOverview = UILabel(frame: CGRect(x: 15, y: 250, width: UIScreen.main.bounds.size.width - 20.0, height: 300))
        view.addSubview(labelOverview)
        labelOverview.textAlignment = .left
        //labelOverview.lineBreakMode = .byWordWrapping
        //labelOverview.sizeToFit()
        labelOverview.numberOfLines = 15
        labelOverview.text = movie.overview
    }
    
    private func addMovieImage(){
        
        let image = UIImageView()
        
        
        guard let imageString = movie.landscapePath else {return}
        
        let movieImageUrl = "https://image.tmdb.org/t/p/w1280" + imageString
        
        guard let imageUrl = URL(string: movieImageUrl) else {
            image.image = UIImage(named: "error at passing the image url from the list")
            return
        }
        
        getImageDataFrom(url: imageUrl, passedImage: image)
        
        image.frame = CGRect(x: 0, y: 0, width: 400, height: 225)
        view.addSubview(image)
    }
    
    //MARK: -get image data
    private func getImageDataFrom(url: URL, passedImage: UIImageView) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Handle error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                //Handle empty data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    passedImage.image = image
                }
            }
            
        }.resume()
    }
    
    private func addButton(){
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width/4, y: 600, width: 200, height: 50))
        button.backgroundColor = .yellow
        button.setTitle("Add to favourites", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!){
        print("Button tapped")
        
        //TODO: if movie is already in the list do not add it!
        
        // the plan is to retrieve the favorites movies array from the user defaults then append
        // the new movie
        
        //read/get data from user defaults
        if let data = UserDefaults.standard.data(forKey: "favoritesMovies"){
            //create json decoder
            do {
                let decoder = JSONDecoder()
                let encoder = JSONEncoder()
                
                //decode movies
                var favoritesMoviesArray = try decoder.decode([Movie].self, from: data)
                favoritesMoviesArray.append(movie)
                print(favoritesMoviesArray)
                
                let newData = try encoder.encode(favoritesMoviesArray)
                
                // write the new data
                // i should be using functions this is bullshit
                
                UserDefaults.standard.set(newData, forKey: "favoritesMovies")
            } catch {
                print("unable to decode/encode movies \(error)")
            }
            
        } else {
            
            // if the execution arrives here it means that there was no initializations of user defaults
            // initialize user defaults with the right key
            // very bad explination, i'll refactor it later :)
            
            let favoritesMovies = [Movie]()
            
            do {
                // create json encoder
                let encoder = JSONEncoder()
                
                // encode note
                let data = try encoder.encode(favoritesMovies)
                
                // write/set data
                UserDefaults.standard.set(data, forKey: "favoritesMovies")
            } catch {
                print("Unable to encode Array of Notes (\(error)")
            }
            
            print("initializing user defaults for array of movies")
        }
        
        //FavoritesMovies.instance.listFavoritesMovies.append(movie)
    }
}
