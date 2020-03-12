//
//  Bowtie+CoreDataProperties.swift
//  Bow Ties
//
//  Created by Mykola Buhaiov on 12.03.2020.
//  Copyright © 2020 Sergey Dunaev. All rights reserved.
//
//

import Foundation
import CoreData


extension Bowtie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bowtie> {
        return NSFetchRequest<Bowtie>(entityName: "Bowtie")
    }

    @NSManaged public var name: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var lastWorn: Date?
    @NSManaged public var rating: Double
    @NSManaged public var searchKey: String?
    @NSManaged public var timeWorn: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var url: URL?
    @NSManaged public var photoData: Data?
    @NSManaged public var tintColor: NSObject?

}
