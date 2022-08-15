//
//  FavoriteViewController.swift
//  EyeMovie
//
//  Created by Marcu Bale on 01.08.2022.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //let userDefaults = UserDefaults.standard
    var favoritesMoviesDecoded = [Movie]()
    
    //let favoritesMovies = FavoritesMovies()
    
    
    func fetchDataFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "favoritesMovies"){
            //create json decoder
            do {
                let decoder = JSONDecoder()
                
                //decode movies
                let favoritesMoviesArray = try decoder.decode([Movie].self, from: data)
                favoritesMoviesDecoded = favoritesMoviesArray
            } catch {
                print("unable to decode \(error)")
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //FavoritesMovies.instance.listFavoritesMovies.count
        
        favoritesMoviesDecoded.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieViewCell.identifier, for: indexPath) as! SearchMovieViewCell
        
        //cell.configure(with: FavoritesMovies.instance.listFavoritesMovies[indexPath.row])
        cell.configure(with: favoritesMoviesDecoded[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMovie = favoritesMoviesDecoded[indexPath.row]
        let movieDetailsView = MovieDetailsView(movie: selectedMovie)
        
        self.present(movieDetailsView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(SearchMovieViewCell.nib(), forCellReuseIdentifier: SearchMovieViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchDataFromUserDefaults()
        
        table.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
