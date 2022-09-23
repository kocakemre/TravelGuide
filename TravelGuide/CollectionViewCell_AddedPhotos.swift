//
//  CollectionViewCell_AddedPhotos.swift
//  TravelGuide
//
//  Created by Emre Kocak on 21.09.2022.
//

import UIKit

protocol PhotoCellProtocol {
    
    func didTrashButtonClicked(photo: Photo, index: Int)

}

class CollectionViewCell_AddedPhotos: UICollectionViewCell {
    
    var delegate : PhotoCellProtocol?
    var photo : Photo!
    var index : Int!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func trashButton(_ sender: Any) {
        delegate?.didTrashButtonClicked(photo: photo!, index: index!)
        
    }
}
