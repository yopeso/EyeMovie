//
//  MyCollectionViewCell.swift
//  EyeMovie
//
//  Created by Marcu Bale on 02.08.2022.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myImageView: UIImageView!
    
    private var urlString: String = ""
    private var urlStringLandscape: String = ""
    
    static let identifier = "MyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //configure the cell by passing a model(movie in our case)
    public func configure(with movie: Movie, landscape: Bool) {
        self.myLabel.text = movie.title
        //self.myImageView.image = UIImage(named: movie.imagePath!)
        
        guard let posterString = movie.imagePath else {return}
        guard let posterStringLandscape = movie.landscapePath else {return}
        
        
        if landscape {
            urlString = "https://image.tmdb.org/t/p/w780" + posterStringLandscape
        } else {
            urlString = "https://image.tmdb.org/t/p/w300" + posterString
        }
        
        
        guard let posterImageUrl = URL(string: urlString) else {
            self.myImageView.image = UIImage(named: "noImageAvailable")
            return
        }
        
        //Before we download the image we clear out the old one
        self.myImageView.image = nil
        
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
                    self.myImageView.image = image
                }
            }
            
        }.resume()
    }
    
}
