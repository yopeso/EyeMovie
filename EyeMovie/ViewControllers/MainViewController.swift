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
    @IBOutlet var middleTable: UITableView!
    //@IBOutlet var bottomTable: UITableView!
    
    var topTableMoviesData = [Movie]()
    var middleTableMoviesData = [Movie]()
    //var bottomTableMoviesData = [Movie]()
    
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
        addMockModels()
        
        //registration of the cells
        topTable.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        middleTable.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        
        topTable.delegate = self
        topTable.dataSource = self
        
        middleTable.delegate = self
        middleTable.dataSource = self
        
//        bottomTable.delegate = self
//        bottomTable.dataSource = self
        
        //Making the tableViews non scrollable
        
        topTable.isScrollEnabled = false
        middleTable.isScrollEnabled = false
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("making a call")
        api.getMockData(url: URL(string: "www.google.com")!) { movies in //should i use weakself?
            print(movies)
            //self.topTableMoviesData = movies
            //self.topTable.reloadData()

//            self.middleTableMoviesData = movies
//            self.middleTable.reloadData()
        }
    }
    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CollectionTableViewCell()
        switch tableView{
        case topTable:
            let cell = topTable.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            
            cell.configure(with: topTableMoviesData)
        case middleTable:
            let cell = middleTable.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            
            cell.configure(with: middleTableMoviesData)
        default:
            print("something went wrong")
            
        }
        //        let cell = topTable.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        //
        //        cell.configure(with: topTableMoviesData)
        //
        return cell
    }
    
    
    //the height of the row that holds the collection view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //TODO: set the right height
        if tableView == topTable{
            return 300
        }
        else if tableView == middleTable{
            return 100
        }
        else {return 200}
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}





