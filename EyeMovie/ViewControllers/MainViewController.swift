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

class MainViewController: UIViewController {
    
    private let table: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        return table
    }()
    
    private var models = [CollectionTableCellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpModels()
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }

    private func setUpModels(){
//        models.append(.collectionView(models: [CollectionTableCellModel(title: "Movie 1", imageName: "movie1")], rows: 2))
        
        models.append(CollectionTableCellModel(title: "Movie 1", imageName: "movie1"))
        models.append(CollectionTableCellModel(title: "Movie 2", imageName: "movie2"))
        models.append(CollectionTableCellModel(title: "Movie 3", imageName: "movie3"))
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch models[section]{
//        case .list(let models): return models.count
//        case .collectionView(let models, _): return models.count
//        }
        
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        
        cell.configure(with: models)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("did select movie")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}


