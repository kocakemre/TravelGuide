//
//  VC_Visited.swift
//  TravelGuide
//
//  Created by Altay Kırlı on 21.09.2022.
//

import UIKit

class VC_Visited: UIViewController {

    //ToVisit TV is tableViewPlaceList, Visited has "places"!!
    @IBOutlet weak var tableViewPlacesList: UITableView!
    
    var list = [Place]()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableViewPlaceList.delegate = self
//        tableViewPlaceList.dataSource = self
        
      appearanceNavigationBar()
        
        view.backgroundColor = UIColor(hexString: "E5E5E5")
        
        
    }
    
  
    // MARK: - Functions
    
    func appearanceNavigationBar() {
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = UIColor(hexString: "4DA7FC")
      
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension VC_Visited: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let place = list[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("TableViewCell_Visited", owner: self, options: nil)?.first as! TableViewCell_PlaceToVisit
        
        cell.bindData(place: place)
        
        return cell
        
    }
    
    
    
}
