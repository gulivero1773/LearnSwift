//
//  EateriesTableViewController.swift
//  Eateries
//
//  Created by Ivan Akulov on 29/09/2016.
//  Copyright © 2016 Ivan Akulov. All rights reserved.
//

import UIKit
import CoreData


class EateriesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  
  var fetchResultsController: NSFetchedResultsController<Restaurant>!
  var searchController: UISearchController!
  var filteredResultArray: [Restaurant] = []
  var restaurants: [Restaurant] = []
  
  
//    Restaurant(name: "Ogonёk Grill&Bar", type: "ресторан", location: "Уфа, бульвар Хадии Давлетшиной 21, вход со стороны улицы", image: "ogonek.jpg", isVisited: false),
//    Restaurant(name: "Елу", type: "ресторан", location: "Уфа", image: "elu.jpg", isVisited: false),
//    Restaurant(name: "Bonsai", type: "ресторан", location: "Уфа", image: "bonsai.jpg", isVisited: false),
//    Restaurant(name: "Дастархан", type: "ресторан", location: "Уфа", image: "dastarhan.jpg", isVisited: false),
//    Restaurant(name: "Индокитай", type: "ресторан", location: "Уфа", image: "indokitay.jpg", isVisited: false),
//    Restaurant(name: "X.O", type: "ресторан-клуб", location: "Уфа", image: "x.o.jpg", isVisited: false),
//    Restaurant(name: "Балкан Гриль", type: "ресторан", location: "Уфа", image: "balkan.jpg", isVisited: false),
//    Restaurant(name: "Respublica", type: "ресторан", location: "Уфа", image: "respublika.jpg", isVisited: false),
//    Restaurant(name: "Speak Easy", type: "ресторанный комплекс", location: "Уфа", image: "speakeasy.jpg", isVisited: false),
//    Restaurant(name: "Morris Pub", type: "ресторан", location: "Уфа", image: "morris.jpg", isVisited: false),
//    Restaurant(name: "Вкусные истории", type: "ресторан", location: "Уфа", image: "istorii.jpg", isVisited: false),
//    Restaurant(name: "Классик", type: "ресторан", location: "Уфа", image: "klassik.jpg", isVisited: false),
//    Restaurant(name: "Love&Life", type: "ресторан", location: "Уфа", image: "love.jpg", isVisited: false),
//    Restaurant(name: "Шок", type: "ресторан", location: "Уфа", image: "shok.jpg", isVisited: false),
//    Restaurant(name: "Бочка", type: "ресторан", location:  "Уфа", image: "bochka.jpg", isVisited: false)]
  
  @IBAction func close(segue: UIStoryboardSegue) {
  
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.hidesBarsOnSwipe = true
  }
  
  func filterContentFor(searchText text: String) {
    filteredResultArray = restaurants.filter { (restaurant) -> Bool in
      return (restaurant.name?.lowercased().contains(text.lowercased()))!
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    tableView.tableHeaderView = searchController.searchBar
    searchController.searchBar.delegate = self
    definesPresentationContext = true
    
    tableView.estimatedRowHeight = 85
    tableView.rowHeight = UITableViewAutomaticDimension
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
   // create fetch request with descriptor
    let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    // getting context
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
      // creating fetch result controller
      fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
      fetchResultsController.delegate = self
      
      // trying to retrieve data
      do {
        try fetchResultsController.performFetch()
        // save retrieved data into restaurants array
        restaurants = fetchResultsController.fetchedObjects!
      } catch let error as NSError {
        print(error.localizedDescription)
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    let userDefaults = UserDefaults.standard
    let wasIntroWatched = userDefaults.bool(forKey: "wasIntroWatched")
    
    guard !wasIntroWatched else { return }
    
    if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "pageViewController") as? PageViewController {
      present(pageViewController, animated: true, completion: nil)
    }
  }
  
  // MARK: - Fetch results controller delegate
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
    switch type {
    case .insert: guard let indexPath = newIndexPath else { break }
    tableView.insertRows(at: [indexPath], with: .fade)
    case .delete: guard let indexPath = indexPath else { break }
      tableView.deleteRows(at: [indexPath], with: .fade)
    case .update: guard let indexPath = indexPath else { break }
      tableView.reloadRows(at: [indexPath], with: .fade)
    default:
      tableView.reloadData()
    }
    restaurants = controller.fetchedObjects as! [Restaurant]
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    if searchController.isActive && searchController.searchBar.text != "" {
      return filteredResultArray.count
    }
    return restaurants.count
  }
  
  func restaurantToDisplayAt(indexPath: IndexPath) -> Restaurant {
    let restaurant: Restaurant
    if searchController.isActive && searchController.searchBar.text != "" {
      restaurant = filteredResultArray[indexPath.row]
    } else {
      restaurant = restaurants[indexPath.row]
    }
    return restaurant
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EateriesTableViewCell
    let restaurant = restaurantToDisplayAt(indexPath: indexPath)
    cell.thumbnailImageView.image = UIImage(data: restaurant.image! as Data)
    cell.thumbnailImageView.layer.cornerRadius = 32.5
    cell.thumbnailImageView.clipsToBounds = true
    cell.nameLabel.text = restaurant.name
    cell.locationLabel.text = restaurant.location
    cell.typeLabel.text = restaurant.type
    
    cell.accessoryType = restaurant.isVisited ? .checkmark : .none
    
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
//  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    // first alert controller with action sheet style
//    let ac = UIAlertController(title: nil, message: "Выберите действие", preferredStyle: .actionSheet)
//    // first alert controller action
//    let call = UIAlertAction(title: "Позвонить: +7(347)111-111\(indexPath.row)", style: .default) {
//      (action: UIAlertAction) -> Void in
//      // second alert controller inside first action
//      let alertC = UIAlertController(title: nil, message: "Вызов не может совершен", preferredStyle: .alert)
//      // second alert controller action
//      let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//      // add action to second alert controller
//      alertC.addAction(ok)
//      // present second alert controler
//      self.present(alertC, animated: true, completion: nil)
//    }
//    // second action
//    let isVisitedTitle = self.restaurantIsVisited[indexPath.row] ? "Я не был здесь" : "Я был здесь"
//    let isVisited = UIAlertAction(title: isVisitedTitle, style: .default) { (action) in
//      let cell = tableView.cellForRow(at: indexPath)
//      
//      self.restaurantIsVisited[indexPath.row] = !self.restaurantIsVisited[indexPath.row]
//      cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
//    }
//    // third action
//    let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
//    // add all actions to first alert controller
//    ac.addAction(call)
//    ac.addAction(isVisited)
//    ac.addAction(cancel)
//    //present first alert controller
//    present(ac, animated: true, completion: nil)
//    
//    tableView.deselectRow(at: indexPath, animated: true)
//  }
  
//  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//    
//    if editingStyle == .delete {
//      self.restaurantImages.remove(at: indexPath.row)
//      self.restaurantNames.remove(at: indexPath.row)
//      self.restaurantIsVisited.remove(at: indexPath.row)
//    }
////    tableView.reloadData()
//    tableView.deleteRows(at: [indexPath], with: .fade)
//  }

  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
    
    let share = UITableViewRowAction(style: .default, title: "Поделиться") { (action, indexPath) in
      let defaultText = "Я сейчас в " + self.restaurants[indexPath.row].name!
      if let image = UIImage(data: self.restaurants[indexPath.row].image! as Data) {
        let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
      }
    }
    
    let delete = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
      self.restaurants.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
        
        let objectToDelete = self.fetchResultsController.object(at: indexPath)
        context.delete(objectToDelete)
        
        do {
          try context.save()
        } catch {
          print(error.localizedDescription)
        }
      }
    }
    
    share.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    return [delete, share]
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "detailSegue" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let dvc = segue.destination as! EateryDetailViewController
        dvc.restaurant = restaurantToDisplayAt(indexPath: indexPath)
      }
    }
  }
}


extension EateriesTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    filterContentFor(searchText: searchController.searchBar.text!)
    tableView.reloadData()
  }
}

extension EateriesTableViewController: UISearchBarDelegate {
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    if searchBar.text == "" {
      navigationController?.hidesBarsOnSwipe = false
    }
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    navigationController?.hidesBarsOnSwipe = true
  }
}









