//
//  PriceInfo+CoreDataProperties.swift
//  Bubble Tea Finder
//
//  Created by Sergey Dunaev on 09/01/2019.
//  Copyright © 2019 SwiftLab. All rights reserved.
//

import Foundation
import CoreData

extension PriceInfo {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PriceInfo> {
        return NSFetchRequest<PriceInfo>(entityName: "PriceInfo")
    }
    
    @NSManaged public var priceCategory: String?
    @NSManaged public var venue: Venue?
    
}
