//
//  Movie.swift
//  EyeMovie
//
//  Created by Marcu Bale on 01.08.2022.
//

import Foundation

enum CellModel {
    case collectionView(models: [CollectionTableCellModel], rows: Int)
    case list(models: [ListCellModel])
}

struct ListCellModel {
    let title: String
}

struct CollectionTableCellModel {
    let title: String
    let imageName: String
}
