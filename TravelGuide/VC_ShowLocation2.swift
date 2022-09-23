//
//  VC_ShowLocation2.swift
//  TravelGuide
//
//  Created by Emre Kocak on 22.09.2022.
//

import UIKit
import MapKit

class VC_ShowLocation2: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var location : CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        TabBarController.customTabBarView.isHidden = true
        
        configureMapView()
        generateAnnotation()
        
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        TabBarController.customTabBarView.isHidden =  false
        
    }
    
    
    func configureMapView(){
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
    }
  

    
    func generateAnnotation(){
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 42, longitude: 42)
        annotation.title = "Name"
        annotation.subtitle = "SubTitle"
        self.mapView.addAnnotation(annotation)
        location = annotation.coordinate
        
    }
    
    
}


