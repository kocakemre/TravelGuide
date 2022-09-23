//
//  VC_AddPlace.swift
//  TravelGuide
//
//  Created by Emre Kocak on 21.09.2022.
//

import UIKit
import CoreData

class VC_AddPlace: UIViewController, UINavigationControllerDelegate {
    
    var descriptionList = [Description]()
    var photoList = [Photo]()
    var selectedImage : UIImage?
    var placeId : UUID?
    

    @IBOutlet weak var collectionViewAddPhoto: UICollectionView!

    @IBOutlet weak var textFieldPlaceName: UITextField!
    @IBOutlet weak var textFieldShortDescription: UITextField!
    @IBOutlet weak var textViewStatement: UITextView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var buttonPrecedenceColor: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewAddPhoto.delegate = self
        collectionViewAddPhoto.dataSource = self
        
        buttonPrecedenceColor.backgroundColor = .green
        segmentedControl.isHidden = true
        appearanceNavigationBar()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        placeId = UUID()
        photoList = DAL.allBringPhotosOfPlace(placeId: placeId!) ?? []
        self.tabBarController?.tabBar.isHidden = false
        TabBarController.customTabBarView.isHidden = false
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
    
    @IBAction func buttonAddLocation(_ sender: Any) {

    }
    
    @IBAction func buttonSave(_ sender: Any) {
        
        
        let description = DAL.createDescription(placeId: placeId!,  description: textViewStatement.text)
        
        descriptionList.append(description)
        
        
        DAL.addPlace(uuid: placeId! , name: textFieldPlaceName.text!,latitude: 42.0,longtitude: 42.0, shortDescription: textFieldShortDescription.text!, longDescriptions: descriptionList, photos: photoList)
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



extension VC_AddPlace : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count + 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(indexPath.row == photoList.count){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addPhotoCell", for: indexPath) as! CollectionViewCell_Photo
            
            cell.delegate = self
                
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! CollectionViewCell_AddedPhotos
            
            if(photoList.count != 0){
                let coredataLoadedimage = UIImage(data: photoList[indexPath.row].photo!)
                cell.imageView.image = coredataLoadedimage
                cell.delegate = self
                cell.index = indexPath.row
                cell.photo = photoList[indexPath.row]
            }

                
            return cell
        }
        
    }
    
    
    
    
    
}


extension VC_AddPlace : UIImagePickerControllerDelegate,photoAddProtocol,PhotoCellProtocol{
    
    
    func didTrashButtonClicked(photo: Photo,index: Int) {
        DAL.deletePhoto(photo: photo)
        photoList.remove(at: index)
        
        DispatchQueue.main.async {
            self.collectionViewAddPhoto.reloadData()
        }
    }

    func didAddPhotoClicked(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true)
        }
        else
        {
            print("Galeriye erişilemiyor")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let photo = DAL.createPhoto(placeId: placeId!,  photo: imageData)
        DAL.addPhoto(photo: photo)
        photoList.append(photo)
        
        DispatchQueue.main.async {
            self.collectionViewAddPhoto.reloadData()
        }
        
        
        
        
        dismiss(animated: true, completion: nil)
        
    }
}


