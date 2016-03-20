//
//  CD.swift
//  ShopCD
//
//  Created by Naga Praveen Kumar Pendyala on 3/7/16.
//  Copyright (c) 2016 Naga Praveen Kumar Pendyala. All rights reserved.
//

import Foundation
import CoreData

class CD: NSManagedObject {

    @NSManaged var artist: String
    @NSManaged var title: String
    @NSManaged var year: NSNumber
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, title: String, artist: String, year: Int) -> CD {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("CD", inManagedObjectContext: moc) as! CD
        newItem.title = title
        newItem.artist = artist
        newItem.year = year
        
        return newItem
    }

}
