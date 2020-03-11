//
//  ViewController.swift
//  HitList
//
//  Created by Mykola Buhaiov on 11.03.2020.
//  Copyright © 2020 Mykola Buhaiov. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var people: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Список "
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Новое имя", message: "Добавьте новое имя", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { [unowned self] (action) in
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else {
                return
            }
            self.save(name: nameToSave)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
    func save(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        person.setValue(name, forKey: "name")
        
        
        do {
            try managedContext.save()
            people.append(person)
        } catch let error  as NSError {
            print("НЕ могу записать. \(error), \(error.userInfo)")
            
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = person.value(forKey: "name") as? String
        return cell 
    }
    
    
}
