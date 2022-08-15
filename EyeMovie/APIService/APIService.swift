//
//  APIService.swift
//  EyeMovie
//
//  Created by Marcu Bale on 03.08.2022.
//

import Foundation

class APIService {
    
    private var dataTask: URLSessionDataTask?
    
    func getPopularMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
        let popularMoviesUrl = "https://api.themoviedb.org/3/trending/all/week?api_key=eb21f459f41bb6dc060c3faee159b32d"
        
        //let popularMoviesUrlExtra = "https://api.themoviedb.org/3/trending/all/week?api_key=eb21f459f41bb6dc060c3faee159b32d&language=en-US&page=1"
        
        guard let url = URL(string: popularMoviesUrl) else {return}
        
        //guard let url2 = URL(string: popularMoviesUrlExtra) else {return}
        
        //Create URL session work on the background
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Handle error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                //Handle empty response
                print("Empty response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                //Handle empty data
                print("Empty data")
                return
            }
            
            do {
                //parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
        
    }
    
    func getUpcomingMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
        let upcomingMoviesUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=eb21f459f41bb6dc060c3faee159b32d&language=en-US&page=1"
        
        guard let url = URL(string: upcomingMoviesUrl) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Handle error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                //Handle empty response
                print("Empty response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                //Handle empty data
                print("Empty data")
                return
            }
            
            do {
                //parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func getTopRatedMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
        let upcomingMoviesUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=eb21f459f41bb6dc060c3faee159b32d&language=en-US&page=1"
        
        guard let url = URL(string: upcomingMoviesUrl) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Handle error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                //Handle empty response
                print("Empty response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                //Handle empty data
                print("Empty data")
                return
            }
            
            do {
                //parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func searchMovies(query: String?, completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
//        let searchMoviesUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=eb21f459f41bb6dc060c3faee159b32d&language=en-US&page=1"
        
        guard let query = query else {
            return
        }

        
        let searchMoviesUrl = "https://api.themoviedb.org/3/search/movie?api_key=eb21f459f41bb6dc060c3faee159b32d&language=en-US&query=\(query)&page=1&include_adult=false"
        
        guard let url = URL(string: searchMoviesUrl) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Handle error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                //Handle empty response
                print("Empty response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                //Handle empty data
                print("Empty data")
                return
            }
            
            do {
                //parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
}
