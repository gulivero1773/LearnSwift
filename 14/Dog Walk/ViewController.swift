//
//  ViewController.swift
//  Dog Walk
//
//  Created by Sergey Dunaev on 25/10/2018.
//  Copyright © 2018 Sergey Dunaev. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: - Properties
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    var managedContext: NSManagedObjectContext!
    
    var currentDog: Dog?
    
    // MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let dogName = "Джек"
        let dogFetch: NSFetchRequest<Dog> = Dog.fetchRequest()
        dogFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Dog.name),
                                         dogName)
        do {
            let results = try managedContext.fetch(dogFetch)
            if results.count > 0 {
                // Джек найден
                currentDog = results.first
            } else {
                // Джек не найден, создать Джека
                currentDog = Dog(context: managedContext)
                currentDog?.name = dogName
                try managedContext.save()
            }
        } catch let error as NSError {
            print("Ошибка выборки: \(error) описание: \(error.userInfo)")
        }
    }
}

// MARK: - IBActions
extension ViewController {
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        //walks.append(Date())
        // Добавить новый объект Walk в Core Data
        let walk = Walk(context: managedContext)
        walk.date = NSDate()
        // Добавить новую "Walk" в множкство прогулок для "Dog"
        //currentDog?.addToWalks(walk)
        walk.dog = currentDog
        // Сохранить контекст управляемого объекта
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Ошибка записи: \(error), description: \(error.userInfo)")
        }
        
        tableView.reloadData()
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDog?.walks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let walk = currentDog?.walks?[indexPath.row] as? Walk,
        let walkDate = walk.date as Date? else {
            return cell
        }
        
        cell.textLabel?.text = dateFormatter.string(from: walkDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Список прогулок"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let walkToRemove = currentDog?.walks?[indexPath.row] as? Walk, editingStyle == .delete else {
            return
        }
        // Удаляем прогулку из Core Data
        managedContext.delete(walkToRemove)
        do {
            try managedContext.save()
            // Анимируем удаление ячейки в таблице
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error as NSError {
            print("Ошибка сохранения: \(error), описание: \(error.userInfo)")
        }
    }
    
}
