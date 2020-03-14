//
//  ImageAttachment.swift
//  UnCloudNotes
//
//  Created by Mykola Buhaiov on 14.03.2020.
//  Copyright © 2020 SwiftLab. All rights reserved.
//

import UIKit
import CoreData

class ImageAttachment: Attachment {
    @NSManaged var image: UIImage?
    @NSManaged var width: Float
    @NSManaged var height: Float
    @NSManaged var caption: String
}
