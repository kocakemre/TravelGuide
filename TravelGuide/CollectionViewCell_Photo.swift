//
//  CollectionViewCell_Photo.swift
//  TravelGuide
//
//  Created by Emre Kocak on 21.09.2022.
//

import UIKit

protocol photoAddProtocol {
    
    func didAddPhotoClicked()
}

class CollectionViewCell_Photo: UICollectionViewCell {
    
   
    var delegate : photoAddProtocol?
    
    
    @IBOutlet weak var addPhotoButton: UIButton!
    
    
    @IBAction func addPhotoClicked(_ sender: Any) {
        
        delegate?.didAddPhotoClicked()
    }
    

    
}

