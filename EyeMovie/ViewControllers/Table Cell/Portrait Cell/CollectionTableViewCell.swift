//
//  CollectionTableViewCell.swift
//  EyeMovie
//
//  Created by Marcu Bale on 02.08.2022.
//

import UIKit

class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "CollectionTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "CollectionTableViewCell", bundle: nil)
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    var movies = [Movie]()
    
    func configure(with movies: [Movie]){
        self.movies = movies
        collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //CollectionView
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        
        cell.configure(with: movies[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //TODO: make the collection view cell the right dimenstion 1080*1920 maybe??
        
        //        return UIImage(named: movies[indexPath.row].imagePath)!.size as CGSize
        
        return CGSize(width: 170, height: 300)
        //return CGSize(width: 150, height: 250)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
    
}
