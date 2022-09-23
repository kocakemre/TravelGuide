//
//  ViewController.swift
//  TravelGuide
//
//  Created by Emre Kocak on 19.09.2022.
//

import UIKit

class VC_ToVisit: UIViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var tableViewPlaceList: UITableView!
    
    var list = [Place]()
    static var colorButton: UIColor = .gray
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
       tableViewPlaceList.delegate = self
       tableViewPlaceList.dataSource = self
        
        appearanceNavigationBar()
        
        view.backgroundColor = UIColor(hexString: "E5E5E5")
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        TabBarController.customTabBarView.isHidden = false
        
        list = DAL.allBringPlaces() ?? []
        tableViewPlaceList.reloadData()
    }
    
    
    
  
    // MARK: - Functions

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail" {
            let vc = segue.destination as! VC_ToVisitDetail
            vc.place = list[sender as! Int]
        }
    }
    
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

extension VC_ToVisit: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let place = list[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("TableViewCell_PlaceToVisit", owner: self, options: nil)?.first as! TableViewCell_PlaceToVisit
        
        cell.bindData(place: place)
        cell.buttonPrecedenceColor.backgroundColor = VC_ToVisit.colorButton
        
        cell.separatorInset.left = 20.0
            cell.separatorInset.right = 20.0
            cell.separatorInset.top = 20.0
            cell.separatorInset.bottom = 20.0
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sgDetail", sender: indexPath.row)
        
    }
    
    
}
