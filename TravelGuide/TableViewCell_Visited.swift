//
//  TableViewCell_PlaceToVisit.swift
//  TravelGuide
//
//  Created by Emre Kocak on 20.09.2022.
//

import UIKit

class TableViewCell_Visited: UITableViewCell {

    @IBOutlet weak var imageViewPlace: UIImageView!
    @IBOutlet weak var labelPlaceName: UILabel!
    @IBOutlet weak var labelShortDescription: UILabel!
    @IBOutlet weak var labelShortStatement: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(place: Place) {
        if place.photoId == nil {
            imageViewPlace.image = UIImage(named: "emptyPlace")
        }
        
        labelPlaceName.text = place.name ?? ""
        labelShortDescription.text = place.shortdesc ?? ""
        labelShortStatement.text = (place.longdesc)?.uuidString ?? ""
        
        
    }
    
}
