//
//  SearchViewController.swift
//  EyeMovie
//
//  Created by Marcu Bale on 01.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private var debouncer: Debouncer!
    
    let api = APIService()
    
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var moviesData = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(SearchMovieViewCell.nib(), forCellReuseIdentifier: SearchMovieViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
        searchBar.delegate = self
        
        // Do any additional setup after loading the view.
        
        debouncer = Debouncer.init(delay: 1, callback: debouncerApiCall)
    }
    
    private func debouncerApiCall() {
        print("debouncer api call")
        searchMovies()
    }
    
//    @IBAction func textChanged(_ sender: Any) {
//        //        textFieldValue = (sender as? UITextField)?.text ?? ""
//
//    }
    
    
    //Field
    
    //TODO: sa nu apara content sub tastatura
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debouncer.call()
    }
    
    func searchMovies(){
        //searchBar.resignFirstResponder()
        
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        fetchPopularMoviesData(query: searchBar.text) { [weak self] in
            self?.table.reloadData()
        }
    }
    
    private func fetchPopularMoviesData(query: String?, completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        api.searchMovies(query: query) { [weak self] (result) in
            print(result)
            switch result{
            case .success(let listOf):
                self?.moviesData = listOf.movies
                completion()
                //self?.topTable.reloadData()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    // Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieViewCell.identifier, for: indexPath) as! SearchMovieViewCell
        
//        for movie in moviesData{
//            print(movie.title)
//            print(movie.id)
//        }
        
        cell.configure(with: moviesData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMovie = self.moviesData[indexPath.row]
        let movieDetailsView = MovieDetailsView(movie: selectedMovie)
        
        self.present(movieDetailsView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
