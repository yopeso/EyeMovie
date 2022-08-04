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
    
    @IBOutlet var topTable: UITableView!
    
    
    var topTableMoviesData = [Movie]()
    var middleTableMoviesData = [Movie]()
    
    private func addMockModels(){
        topTableMoviesData.append(Movie(title: "Movie 1", imagePath: "movie1"))
        topTableMoviesData.append(Movie(title: "Movie 2", imagePath: "movie2"))
        topTableMoviesData.append(Movie(title: "Movie 3", imagePath: "movie3"))
        
        //middle table
        
        middleTableMoviesData.append(Movie(title: "Movie 3", imagePath: "movie3"))
        middleTableMoviesData.append(Movie(title: "Movie 2", imagePath: "movie2"))
        middleTableMoviesData.append(Movie(title: "Movie 1", imagePath: "movie1"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addMockModels()
        
        //registration of the cells
        topTable.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        topTable.delegate = self
        topTable.dataSource = self
        
        //Making the tableViews non scrollable
        
        topTable.isScrollEnabled = false
        topTable.separatorColor = UIColor.clear
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("making a call")
        api.getMockData(url: URL(string: "www.google.com")!) { movies in //should i use weakself?
            print(movies)
            self.topTableMoviesData = movies
            
            
            self.middleTableMoviesData = movies
            
            
            self.topTable.reloadData()
        }
    }
    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            let cell = topTable.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            
            cell.configure(with: topTableMoviesData)
            return cell
            
        }
        else
        {
            let cell = topTable.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            
            cell.configure(with: middleTableMoviesData)
            return cell
            
        }
        
    }
    
    //the height of the row that holds the collection view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //TODO: set the right height
        if indexPath.section == 0{
            return 250
        }
        else{
            return 100
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Top movies"
        }
        else {
            return "Upcoming movies"
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.gray
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .left
        
        
    }
    
}








