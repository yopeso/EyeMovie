//
//  ViewController.swift
//  EyeMovie
//
//  Created by Marcu Bale on 01.08.2022.
//

import UIKit

// 3 table views horizontaly
// Network req
// tap a cell to see info about a movie
// custom view to see the info about the movie

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let api = APIService()
    let movieData = MovieData()
    
    @IBOutlet var topTable: UITableView!
    
//
//    var topSectionMoviesData = [Movie]()
//    var middleSectionMoviesData = [Movie]()
//    var downSectionMoviesData = [Movie]()
    
    //    private func addMockModels() {
    //        topTableMoviesData.append(Movie(title: "Movie 1", imagePath: "movie1"))
    //        topTableMoviesData.append(Movie(title: "Movie 2", imagePath: "movie2"))
    //        topTableMoviesData.append(Movie(title: "Movie 3", imagePath: "movie3"))
    //
    //        //middle table
    //
    //        middleTableMoviesData.append(Movie(title: "Movie 3", imagePath: "movie3"))
    //        middleTableMoviesData.append(Movie(title: "Movie 2", imagePath: "movie2"))
    //        middleTableMoviesData.append(Movie(title: "Movie 1", imagePath: "movie1"))
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addMockModels()
        
        //registration of the cells
        topTable.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        
        topTable.delegate = self
        topTable.dataSource = self
        
        //Making the tableViews non scrollable
        
        topTable.isScrollEnabled = true
        topTable.separatorColor = UIColor.clear
        
        
        
        //        fetchPopularMoviesData { [weak self] movies in
        //            self?.topSectionMoviesData = movies
        //            self?.topTable.reloadData()
        //        }
        
        loadMovies() { [weak self] in
            self?.topTable.reloadData()
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func loadMovies(completion: @escaping (() -> Void)) {
        let group = DispatchGroup()
        
        group.enter()
        api.getPopularMoviesData { [weak self] result in
            print(result)
            switch result{
            case .success(let movies):
                self?.movieData.setPopular(movies: movies.movies)
//                self?.topSectionMoviesData = movies.movies
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
            group.leave()
        }
        
        group.enter()
        api.getUpcomingMoviesData { [weak self] result in
            print(result)
            switch result{
            case .success(let movies):
                self?.movieData.setUpcoming(movies: movies.movies)

                //self?.middleSectionMoviesData = movies.movies
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
            group.leave()
        }
        
        group.enter()
        api.getTopRatedMoviesData { [weak self] result in
            print(result)
            switch result{
            case .success(let movies):
                self?.movieData.setTopRated(movies: movies.movies)

                //self?.downSectionMoviesData = movies.movies
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            completion()
        }
    }
    
    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = topTable.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        cell.configure(with: movieData.sections[indexPath.section])
        
        return cell
        
    }
    
    //the height of the row that holds the collection view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //TODO: set the right height
        if indexPath.section == 0{
            return 270
        }
        else {
            return 150
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieData.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        movieData.sections[section].title
    
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.gray
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .left
        
        
    }
    
}








