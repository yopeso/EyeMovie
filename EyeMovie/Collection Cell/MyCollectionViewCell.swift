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
    
    static let identifier = "MyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //configure the cell by passing a model(movie in our case)
    public func configure(with movie: Movie){
        self.myLabel.text = movie.title
        self.myImageView.image = UIImage(named: movie.imagePath)
    }

}
