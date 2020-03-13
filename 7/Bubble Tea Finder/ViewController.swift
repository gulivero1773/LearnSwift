//
//  ViewController.swift
//  Bubble Tea Finder
//
//  Created by Sergey Dunaev on 09/01/2019.
//  Copyright © 2019 SwiftLab. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: - Properties
    private let filterViewControllerSegueIdentifier = "toFilterViewController"
    private let venueCellIdentifier = "VenueCell"
    
    var coreDataStack: CoreDataStack!
    var fetchRequest: NSFetchRequest<Venue>?
    var venues: [Venue] = []
    var asyncFetchRequest: NSAsynchronousFetchRequest<Venue>?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let batchUpdate = NSBatchUpdateRequest(entityName: "Venue")
        batchUpdate.propertiesToUpdate = [#keyPath(Venue.favorite): true]
        batchUpdate.affectedStores = coreDataStack.managedContext.persistentStoreCoordinator?.persistentStores
        batchUpdate.resultType = .updatedObjectsCountResultType
        
        do {
            let batchResult = try coreDataStack.managedContext.execute(batchUpdate) as! NSBatchUpdateResult
            print("Records updated \(batchResult.result!)")
        } catch let error as NSError {
            print("Could not update \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == filterViewControllerSegueIdentifier,
            let navController = segue.destination as? UINavigationController,
            let filterVC = navController.topViewController as? FilterViewController else {
            return
        }
        
        filterVC.coreDataStack = coreDataStack
        filterVC.delegate = self
    }
}

// MARK: - IBActions
extension ViewController {
    
    @IBAction func unwindToVenueListViewController(_ segue: UIStoryboardSegue) {
    }
}

// MARK: - Helper methods
extension ViewController {
    func fetchAndReload() {
        guard let fetchRequest = fetchRequest else {
            return
        }
        do {
            venues = try coreDataStack.managedContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: venueCellIdentifier, for: indexPath)
        let venue = venues[indexPath.row]
        cell.textLabel?.text = venue.name
        cell.detailTextLabel?.text = venue.priceInfo?.priceCategory
        return cell
    }
}

// MARK: - FilterViewControllerDelegate
extension ViewController: FilterViewControllerDelegate {
    func filterViewController(filter: FilterViewController, didSelectPredicate predicate: NSPredicate?, sortDescriptor: NSSortDescriptor?) {
        guard let fetchRequest = fetchRequest else {
            return
        }
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = nil
        
        if let sr = sortDescriptor {
            fetchRequest.sortDescriptors = [sr]
        }
        
        fetchAndReload()
    }
}
