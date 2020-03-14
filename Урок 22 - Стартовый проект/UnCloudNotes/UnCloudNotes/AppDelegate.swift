//
//  AppDelegate.swift
//  UnCloudNotes
//
//  Created by Sergey Dunaev on 15/01/2019.
//  Copyright © 2019 SwiftLab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        if let splitController = window?.rootViewController as? UISplitViewController {
            splitController.delegate = self
        }
        return true
    }
}

// MARK: - UISplitViewControllerDelegate
extension AppDelegate: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNoteDetail = secondaryViewController as? NoteDetailViewController else {
            return false
        }
        
        // Возвращает true, чтобы указать, что мы обработали коллапс, ничего не делая; вторичный контроллер будет сброшен.
        return secondaryAsNoteDetail.note == nil
    }
}
