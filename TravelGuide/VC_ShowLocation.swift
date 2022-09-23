//
//  VC_ShowLocation.swift
//  TravelGuide
//
//  Created by Emre Kocak on 22.09.2022.
//

import UIKit

class VC_ShowLocation: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        TabBarController.customTabBarView.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        TabBarController.customTabBarView.isHidden =  false
    }
}
