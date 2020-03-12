//
//  ViewController.swift
//  Bow Ties
//
//  Created by Sergey Dunaev on 22/10/2018.
//  Copyright © 2018 Sergey Dunaev. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timesWornLabel: UILabel!
    @IBOutlet weak var lastWornLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    var managedContext: NSManagedObjectContext!
    var currentBowtie: Bowtie!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Добавить данные в Core Data
        insertSampleData()
        // Создать запрос на выборку и добавить предикат с выбором цвета, указанного в 1-м сегменте
        let request: NSFetchRequest<Bowtie> = Bowtie.fetchRequest()
        let firstTitle = segmentedControl.titleForSegment(at: 0)!
        request.predicate = NSPredicate(
            format: "%K = %@",
            argumentArray: [#keyPath(Bowtie.searchKey), firstTitle])
        do {
            // Получить выборку
            let results = try managedContext.fetch(request)
            currentBowtie = results.first
            // Отобразить данные
            populate(bowtie: results.first!)
        } catch let error as NSError {
            print("Не могу получить выборку: \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - IBActions
    @IBAction func segmentedControl(_ sender: Any) {
        
    }
    
    @IBAction func wear(_ sender: Any) {
        let times = currentBowtie.timesWorn
        currentBowtie.timesWorn = times + 1
        currentBowtie.lastWorn = Date() as NSDate
        
        do {
            try managedContext.save()
            populate(bowtie: currentBowtie)
        } catch let error as NSError {
            print("Не могу получить выборку: \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func rate(_ sender: Any) {
        let alert = UIAlertController(title: "Новый рейтинг",
                                      message: "Рейтинг для этой бабочки",
                                      preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .decimalPad
        }
        let cancelAction = UIAlertAction(title: "Отмена",
                                         style: .cancel)
        let saveAction = UIAlertAction(title: "Сохранить",
                                       style: .default) {
                                        [unowned self] action in
                                        if let textField = alert.textFields?.first {
                                            self.update(rating: textField.text)
                                        }
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true)
    }
    
    func update(rating: String?) {
        guard let ratingString = rating,
            let rating = Double(ratingString) else {
                return
        }
        do {
            currentBowtie.rating = rating
            try managedContext.save()
            populate(bowtie: currentBowtie)
        } catch let error as NSError {
            print("Не могу записать: \(error), \(error.userInfo)")
        }
    }
    
    func populate(bowtie: Bowtie) {
        guard let imageData = bowtie.photoData as Data?,
            let lastWorn = bowtie.lastWorn as Date?,
            let tintColor = bowtie.tintColor as? UIColor else {
                return
        }
        
        imageView.image = UIImage(data: imageData)
        nameLabel.text = bowtie.name
        ratingLabel.text = "Рейтинг: \(bowtie.rating)/5"
        
        timesWornLabel.text = "# раз носил: \(bowtie.timesWorn)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        lastWornLabel.text = "Последний раз надевал: " + dateFormatter.string(from: lastWorn)
        
        favoriteLabel.isHidden = !bowtie.isFavorite
        view.tintColor = tintColor
    }
    
    // Добавить данные
    func insertSampleData() {
        let fetch: NSFetchRequest<Bowtie> = Bowtie.fetchRequest()
        fetch.predicate = NSPredicate(format: "searchKey != nil")
        
        let count = try! managedContext.count(for: fetch)
        
        if count > 0 {
            // Данные из SampleData.plist уже в Core Data
            return
        }
        let path = Bundle.main.path(forResource: "SampleData",
                                    ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)!
        
        for dict in dataArray {
            let entity = NSEntityDescription.entity(
                forEntityName: "Bowtie",
                in: managedContext)!
            let bowtie = Bowtie(entity: entity, insertInto: managedContext)
            let btDict = dict as! [String: Any]
            
            bowtie.id = UUID(uuidString: btDict["id"] as! String)
            bowtie.name = btDict["name"] as? String
            bowtie.searchKey = btDict["searchKey"] as? String
            bowtie.rating = btDict["rating"] as! Double
            let colorDict = btDict["tintColor"] as! [String: Any]
            bowtie.tintColor = UIColor.color(dict: colorDict)
            
            let imageName = btDict["imageName"] as? String
            let image = UIImage(named: imageName!)
            let photoData = image!.pngData()!
            bowtie.photoData = NSData(data: photoData)
            bowtie.lastWorn = btDict["lastWorn"] as? NSDate
            
            let timesNumber = btDict["timesWorn"] as! NSNumber
            bowtie.timesWorn = timesNumber.int32Value
            bowtie.isFavorite = btDict["isFavorite"] as! Bool
            bowtie.url = URL(string: btDict["url"] as! String)
        }
        try! managedContext.save()
    }
}

private extension UIColor {
    static func color(dict: [String : Any]) -> UIColor? {
        guard let red = dict["red"] as? NSNumber,
            let green = dict["green"] as? NSNumber,
            let blue = dict["blue"] as? NSNumber else {
                return nil
        }
        
        return UIColor(red: CGFloat(truncating: red) / 255.0,
                       green: CGFloat(truncating: green) / 255.0,
                       blue: CGFloat(truncating: blue) / 255.0,
                       alpha: 1)
    }
}
