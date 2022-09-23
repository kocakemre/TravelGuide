//
//  VC_ToVisitDetail.swift
//  TravelGuide
//
//  Created by Emre Kocak on 20.09.2022.
//

import UIKit

class VC_ToVisitDetail: UIViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var collectionViewSlider: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var textFieldShortDesc: UITextField!
    @IBOutlet weak var textViewLongDesc: UITextView!
    var placePhotos = [UIImage]()
    @IBOutlet weak var buttonPrecedenceColor: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    var timer: Timer?
    var currentCellIndex = 0
    var place: Place?
    var descriptionList = [Description]()
    
    var uuid = UUID()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewSlider.delegate = self
        collectionViewSlider.dataSource = self

        appearanceNavigationBar()
        startTimer()
        
        segmentedControl.isHidden = true
        buttonPrecedenceColor.backgroundColor = .green
        
        view.backgroundColor = UIColor(hexString: "E5E5E5")
        
        if(place != nil){
            
            descriptionList = DAL.bringPlaceDescription(uuid: place!.id!) ?? []
            
            
            textFieldShortDesc.text = place?.shortdesc
            
            if(descriptionList.count != 0){
                textViewLongDesc.text = descriptionList[0].desc
            }
            
            
            getPhotosFromCoreData()

        }
    }
    
    func getPhotosFromCoreData(){
        let photos = DAL.allBringPhotosOfPlace(placeId: place!.id!)
        
        
        if(photos!.count == 0){
            placePhotos.append(UIImage(named: "emptyPlace")!)
        }
        else{
            for p in photos! {
                
                let coredataLoadedimage = UIImage(data: p.photo!)
                placePhotos.append(coredataLoadedimage!)
            }
        }
        

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        TabBarController.customTabBarView.isHidden = false
        pageControl.numberOfPages = placePhotos.count
        
    }
    
    // MARK: - Functions
    
    func startTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextIndex() {
        
        if currentCellIndex < placePhotos.count - 1 {
            currentCellIndex += 1
        }else {
            currentCellIndex = 0
        }
        
        
        collectionViewSlider.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentCellIndex
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
    
    @IBAction func buttonPrecedence_TUI(_ sender: Any) {
        
        self.segmentedControl.isHidden = false
    }
    
    @IBAction func buttonSegmentedControl_TUI(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
    
            buttonPrecedenceColor.backgroundColor = .green
            
            self.segmentedControl.isHidden = true
            
            VC_ToVisit.colorButton = .green
            
        }else if sender.selectedSegmentIndex == 1 {
         
            buttonPrecedenceColor.backgroundColor = .systemBlue
            self.segmentedControl.isHidden = true
            
            VC_ToVisit.colorButton = .systemBlue
            
        } else {
            
            buttonPrecedenceColor.backgroundColor = .gray
            self.segmentedControl.isHidden = true
            
            VC_ToVisit.colorButton = .gray
            
        }
    }


}

extension VC_ToVisitDetail: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! CollectionViewCell_Slider
        
        cell.imageViewPlacePhoto.image = placePhotos[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
