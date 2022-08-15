//
//  SearchMovieViewCell.swift
//  EyeMovie
//
//  Created by Marcu Bale on 09.08.2022.
//

import UIKit

class SearchMovieViewCell: UITableViewCell {
    
    @IBOutlet var movieTitleLabel: UILabel!
    //@IBOutlet var movieYearLabel: UILabel!
    @IBOutlet var moviePosterImageView: UIImageView!
    
    static let identifier = "SearchMovieViewCell"
    
    private var urlString: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SearchMovieViewCell", bundle: nil)
    }
    
    func configure(with movie: Movie){
        self.movieTitleLabel.text = movie.title
        //self.movieYearLabel.text = movie.year //TODO: add release year property to movie model
        
        guard let posterPath = movie.imagePath else {return}
        
        urlString = "https://image.tmdb.org/t/p/w300" + posterPath
        
        guard let posterImageUrl = URL(string: urlString) else {
            self.moviePosterImageView.image = UIImage(named: "noImageAvailable")
            return
        }
        
        //Before we download the image we clear out the old one
        self.moviePosterImageView.image = nil
        
        getImageDataFrom(url: posterImageUrl)
    }
    
    //MARK: -get image data
    private func getImageDataFrom(url: URL) {
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
                    self.moviePosterImageView.image = image
                }
            }
            
        }.resume()
    }
}
