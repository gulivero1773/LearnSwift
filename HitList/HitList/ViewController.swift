//
//  ViewController.swift
//  HitList
//
//  Created by Mykola Buhaiov on 11.03.2020.
//  Copyright © 2020 Mykola Buhaiov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var names: [String] = []
    
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
            self.names.append(nameToSave)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell 
    }
    
    
}
