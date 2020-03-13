//
//  Stats+CoreDataProperties.swift
//  Bubble Tea Finder
//
//  Created by Sergey Dunaev on 09/01/2019.
//  Copyright © 2019 SwiftLab. All rights reserved.
//

import Foundation
import CoreData

extension Stats {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stats> {
        return NSFetchRequest<Stats>(entityName: "Stats")
    }
    
    @NSManaged public var checkinsCount: Int32
    @NSManaged public var tipCount: Int32
    @NSManaged public var usersCount: Int32
    @NSManaged public var venue: Venue?
    
}
