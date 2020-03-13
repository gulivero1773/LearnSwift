//
//  Venue+CoreDataProperties.swift
//  Bubble Tea Finder
//
//  Created by Sergey Dunaev on 09/01/2019.
//  Copyright © 2019 SwiftLab. All rights reserved.
//

import Foundation
import CoreData

extension Venue {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Venue> {
        return NSFetchRequest<Venue>(entityName: "Venue")
    }
    
    @NSManaged public var favorite: Bool
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var specialCount: Int32
    @NSManaged public var category: Category?
    @NSManaged public var location: Location?
    @NSManaged public var priceInfo: PriceInfo?
    @NSManaged public var stats: Stats?
    
}
