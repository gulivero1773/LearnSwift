//
//  Walk+CoreDataProperties.swift
//  Dog Walk
//
//  Created by Sergey Dunaev on 03/11/2018.
//  Copyright © 2018 Sergey Dunaev. All rights reserved.
//
//

import Foundation
import CoreData


extension Walk {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Walk> {
        return NSFetchRequest<Walk>(entityName: "Walk")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var dog: Dog?

}
