//
//  ImageTransformer.swift
//  UnCloudNotes
//
//  Created by Sergey Dunaev on 15/01/2019.
//  Copyright © 2019 SwiftLab. All rights reserved.
//

import Foundation
import UIKit

class ImageTransformer: ValueTransformer {
    
    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            return nil
        }
        
        return UIImage(data: data)
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else {
            return nil
        }
        
        return image.pngData()
    }
}
