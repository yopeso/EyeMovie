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
    
    
    var topSectionMoviesData = [Movie]()
    var middleSectionMoviesData = [Movie]()
    var downSectionMoviesData = [Movie]()
    
//    private func addMockModels(){
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
        topTable.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        topTable.delegate = self
        topTable.dataSource = self
        
        //Making the tableViews non scrollable
        
        topTable.isScrollEnabled = true
        topTable.separatorColor = UIColor.clear
        
        fetchPopularMoviesData{[weak self] in
            self?.topTable.reloadData()
        }
        
        fetchUpcomingMoviesData {[weak self] in
            self?.topTable.reloadData()
        }
        
        fetchTopRatedMoviesData {[weak self] in
            self?.topTable.reloadData()
        }
        
        //Applying the gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemGray
        ]
        view.layer.addSublayer(gradientLayer)
        
        // Do any additional setup after loading the view.
    }
    
    private func fetchPopularMoviesData(completion: @escaping () -> ()){
        
        // weak self - prevent retain cycles
        api.getPopularMoviesData { [weak self] (result) in
            print(result)
            switch result{
            case .success(let listOf):
                self?.topSectionMoviesData = listOf.movies
                completion()
                //self?.topTable.reloadData()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    private func fetchUpcomingMoviesData(completion: @escaping () -> ()){
        // weak self - prevent retain cycles
        api.getUpcomingMoviesData { [weak self] (result) in
            print(result)
            switch result{
            case .success(let listOf):
                self?.middleSectionMoviesData = listOf.movies
                completion()
                //self?.topTable.reloadData()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    private func fetchTopRatedMoviesData(completion: @escaping () -> ()){
        // weak self - prevent retain cycles
        api.getTopRatedMoviesData { [weak self] (result) in
            print(result)
            switch result{
            case .success(let listOf):
                self?.downSectionMoviesData = listOf.movies
                completion()
                //self?.topTable.reloadData()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            let cell = topTable.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
                        
            cell.configure(with: topSectionMoviesData)
            return cell
            
        }
        
        if indexPath.section == 1 {
            let cell = topTable.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            
            for m in middleSectionMoviesData{
                m.isLandscape = true
            }
            
            cell.configure(with: middleSectionMoviesData)
            return cell
            
        } else {
            let cell = topTable.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            
            for m in downSectionMoviesData{
                m.isLandscape = true
            }
            
            cell.configure(with: downSectionMoviesData)
            return cell
        }
        
    }
    
    //the height of the row that holds the collection view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //TODO: set the right height
        if indexPath.section == 0{
            return 300
        }
        else {
            return 150
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Top movies"
        }
        if section == 1 {
            return "Upcoming movies"
        }
        else {
            return "Top rated movies"
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








