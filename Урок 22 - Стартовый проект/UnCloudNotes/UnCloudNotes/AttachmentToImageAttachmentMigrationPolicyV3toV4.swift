//
//  AttachmentToImageAttachmentMigrationPolicyV3toV4.swift
//  UnCloudNotes
//
//  Created by Mykola Buhaiov on 14.03.2020.
//  Copyright © 2020 SwiftLab. All rights reserved.
//

import UIKit
import CoreData


let errorDomain = "Migration"

class AttachmentToImageAttachmentMigrationPolicyV3toV4: NSEntityMigrationPolicy {
    override func createDestinationInstances(forSource sInstance: NSManagedObject,
                                             in mapping: NSEntityMapping,
                                             manager: NSMigrationManager) throws {
        // 1
        let description = NSEntityDescription.entity(forEntityName: "ImageAttachment", in: manager.destinationContext)
        let newAttachment = ImageAttachment(entity: description!, insertInto: manager.destinationContext)
        
        // 2
        func traversePropertyMappings(block: (NSPropertyMapping, String) -> ()) throws {
            if let attributeMappings = mapping.attributeMappings {
                for propertyMapping in attributeMappings {
                    if let destinationName = propertyMapping.name {
                        block(propertyMapping, destinationName)
                    } else {
                        
                        // 3
                        let message = "Атрибут назначения не настроен должным образом"
                        let userInfo = [NSLocalizedFailureReasonErrorKey: message]
                        throw NSError(domain: errorDomain, code: 0, userInfo: userInfo)
                    }
                }
            } else {
                let message = "Не найдено сопоставлений атрибутов!"
                let userInfo = [NSLocalizedFailureReasonErrorKey: message]
                throw NSError(domain: errorDomain, code: 0, userInfo: userInfo)
            }
        }
        
        // 4
        try traversePropertyMappings { propertyMapping, destinationName in
            if let valueExpression = propertyMapping.valueExpression {
                let context: NSMutableDictionary = ["source": sInstance]
                guard let destinationValue = valueExpression.expressionValue(with: sInstance, context: context) else {
                    return
                }
                newAttachment.setValue(destinationValue, forKey: destinationName)
            }
        }
        
        // 5
        if let image = sInstance.value(forKey: "image") as? UIImage {
            newAttachment.setValue(image.size.width, forKey: "width")
            newAttachment.setValue(image.size.height, forKey: "height")
        }
        
        // 6
        let body = sInstance.value(forKeyPath: "note.body") as? NSString ?? ""
        newAttachment.setValue(body.substring(to: 80), forKey: "caption")
        
        // 7
        manager.associate(sourceInstance: sInstance, withDestinationInstance: newAttachment, for: mapping)
    }

}
