//
//  TableViewCell_PlaceToVisit.swift
//  TravelGuide
//
//  Created by Emre Kocak on 20.09.2022.
//

import UIKit

class TableViewCell_PlaceToVisit: UITableViewCell {

    @IBOutlet weak var imageViewPlace: UIImageView!
    @IBOutlet weak var labelPlaceName: UILabel!
    @IBOutlet weak var labelShortDescription: UILabel!
    @IBOutlet weak var labelShortStatement: UILabel!
    @IBOutlet weak var buttonPrecedenceColor: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(place: Place) {
        if place.photoId == nil {
            imageViewPlace.image = UIImage(named: "emptyPlace")
        }
        
        var photos = DAL.allBringPhotosOfPlace(placeId: place.id!)
        
        
        
        labelPlaceName.text = place.name ?? ""
        labelShortDescription.text = place.shortdesc ?? ""
        labelShortStatement.text = (place.longdesc)?.uuidString ?? ""
        
        
        let emptyImge = UIImage(named: "emptyPlace")
        guard let emptyImageData = emptyImge!.jpegData(compressionQuality: 0.5) else { return }
        
    
        if(photos!.count == 0){
            let coredataLoadedimage = UIImage(data: emptyImageData)
            imageViewPlace.image = coredataLoadedimage
        }
        else{
            let coredataLoadedimage = UIImage(data: photos![0].photo!)
            imageViewPlace.image = coredataLoadedimage
        }


    }
    
}
