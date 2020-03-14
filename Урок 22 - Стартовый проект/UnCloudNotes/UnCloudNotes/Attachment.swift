//
//  Attachment.swift
//  UnCloudNotes
//
//  Created by Mykola Buhaiov on 14.03.2020.
//  Copyright © 2020 SwiftLab. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Attachment: NSManagedObject {
    @NSManaged var dateCreated: Date
    @NSManaged var image: UIImage?
    @NSManaged var note: Note? 
}
