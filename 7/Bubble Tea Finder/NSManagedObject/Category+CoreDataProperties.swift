//
//  Category+CoreDataProperties.swift
//  Bubble Tea Finder
//
//  Created by Sergey Dunaev on 09/01/2019.
//  Copyright © 2019 SwiftLab. All rights reserved.
//

import Foundation
import CoreData

extension Category {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }
    
    @NSManaged public var categoryID: String?
    @NSManaged public var name: String?
    @NSManaged public var venue: Venue?
    
}
