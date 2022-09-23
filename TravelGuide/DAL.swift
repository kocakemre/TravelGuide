//
//  DAL.swift
//  TravelGuide
//
//  Created by Emre Kocak on 21.09.2022.
//

import Foundation
import CoreData
import UIKit

class DAL {
    
    static func getContext() -> NSManagedObjectContext {
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    static func addPlace(uuid: UUID, name: String,latitude: Double,longtitude: Double ,shortDescription: String, longDescriptions: [Description], photos: [Photo]?) {
        
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Place", in: context)
    
        
        let place = NSManagedObject(entity: entity!, insertInto: context)
        
       
        
        place.setValue(uuid, forKey: "id")
        place.setValue(name, forKey: "name")
        place.setValue(shortDescription, forKey: "shortdesc")
        place.setValue(latitude, forKey: "latitude")
        place.setValue(longtitude, forKey: "longtitude")
        
 
        
        let entityPhoto = NSEntityDescription.entity(forEntityName: "Photo", in: context)
        
        if photos != nil{
            for p in photos! {
               let photo = NSManagedObject(entity: entityPhoto!, insertInto: context)
                photo.setValue(p.placeId, forKey: "placeId")
                photo.setValue(p.photo, forKey: "photo")
            }
        }
        

        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Description", in: context)
        
        for ld in longDescriptions {
            let description = NSManagedObject(entity: entityDescription!, insertInto: context)
            description.setValue(ld.placeId, forKey: "placeId")
            description.setValue(ld.desc, forKey: "desc")
        }
        
        do {
            try context.save()
        }catch {
            
        }
    }
    
    
    
    static func addPhoto(photo: Photo) {
        
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Photo", in: context)
    
        
        let myPhoto = NSManagedObject(entity: entity!, insertInto: context)
        
        myPhoto.setValue(photo.placeId, forKey: "placeId")
        myPhoto.setValue(photo.photo, forKey: "photo")
        
        
        do {
            try context.save()
        }catch {
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
   
    static func allBringPlaces() -> [Place]? {
        
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        
        do {
            return try getContext().fetch(fetchRequest)
        }catch {
            
        }
        return nil
    }
    
    static func allBringPhotosOfPlace(placeId: UUID) -> [Photo]? {
        
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        
        let query = NSPredicate(format: "%K == %@", "placeId", placeId as CVarArg)
        
        fetchRequest.predicate = query
        
        
        do {
            return try getContext().fetch(fetchRequest)
        }catch {
            
        }
        return nil
    }
    
    
    static func updatePlace() {
        try? getContext().save()
    }
    
    static func deletePlace(place: Place) {
        getContext().delete(place)
        try? getContext().save()
    }
    
    static func createDescription(placeId: UUID, description: String) -> Description {
        
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Description", in: context)
        
        let myDescription = NSManagedObject(entity: entity!, insertInto: context) as! Description
        
        myDescription.setValue(placeId, forKey: "placeId")
        myDescription.setValue(description, forKey: "desc")
        
        return myDescription
    }
    
    
    
    static func createPhoto(placeId: UUID, photo: Data) -> Photo {
        
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Photo", in: context)
        
        let myPhoto = NSManagedObject(entity: entity!, insertInto: context) as! Photo
        
        myPhoto.setValue(placeId, forKey: "placeId")
        myPhoto.setValue(photo, forKey: "photo")
        
        return myPhoto
    }
    

    
    static func deleteDescription(description: Description) {
        getContext().delete(description)
        try? getContext().save()
    }
    
    static func deletePhoto(photo: Photo) {
        getContext().delete(photo)
        try? getContext().save()
    }
    
    static func bringPlaceDescription(uuid: UUID) -> [Description]? {
       
        let fetchRequest : NSFetchRequest<Description> = Description.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "placeId == %@", uuid as CVarArg)
        
        do
        {
            return try getContext().fetch(fetchRequest)
        }
        catch
        {
            
        }
        
        return nil
    }
    
    static func deletePlaceDescription(descriptionList : [Description])
    {
        for description in descriptionList
        {
            deleteDescription(description: description)
        }
    }
    
}
