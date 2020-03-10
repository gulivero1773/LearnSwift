//
//  NewEateryTableViewController.swift
//  Eateries
//
//  Created by Ivan Akulov on 04/10/2016.
//  Copyright © 2016 Ivan Akulov. All rights reserved.
//

import UIKit
import CloudKit

class NewEateryTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var adressTextField: UITextField!
  @IBOutlet weak var typeTextField: UITextField!
  @IBOutlet weak var yesButton: UIButton!
  @IBOutlet weak var noButton: UIButton!
  var isVisited = false
  
  @IBAction func toggleIsVisitedPressed(_ sender: UIButton) {
    if sender == yesButton {
      sender.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
      noButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
      isVisited = true
    } else {
      sender.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
      yesButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
      isVisited = false
    }
  }
  
  @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
    if nameTextField.text == "" || adressTextField.text == "" || typeTextField.text == "" {
      let alertController = UIAlertController(title: "Ошибка!", message: "Не все поля были заполнены!", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(okAction)
      present(alertController, animated: true, completion: nil)
    } else {
      // trying to get context
      if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
        // create entity of our restaurant class in the context
        let restaurant = Restaurant(context: context)
        // set all the properties
        restaurant.name = nameTextField.text
        restaurant.location = adressTextField.text
        restaurant.type = typeTextField.text
        restaurant.isVisited = isVisited
        if let image = imageView.image {
          // as we expect to get binary data
          restaurant.image = UIImagePNGRepresentation(image)
        }
        // trying to save context
        do {
          try context.save()
          print("Сохранение удалось!")
        } catch let error as NSError {
          print("Не удалось сохранить данные \(error), \(error.userInfo)")
        }
        saveToCloud(restaurant)
      }
      
      performSegue(withIdentifier: "unwindSegueFromNewEatery", sender: self)
    }
  }
  
  func saveToCloud(_ restaurant: Restaurant) {
  
    let restRecord = CKRecord(recordType: "Restaurant")
    restRecord.setValue(nameTextField.text, forKey: "name")
    restRecord.setValue(typeTextField.text, forKey: "type")
    restRecord.setValue(adressTextField.text, forKey: "location")
    
    guard let originImage = UIImage(data: restaurant.image! as Data) else { return }
    let scale = originImage.size.width > 1080.0 ? 1080.0 / originImage.size.width : 1.0
    let scaledImage = UIImage(data: restaurant.image! as Data, scale: scale)
    let imageFilePath = NSTemporaryDirectory() + restaurant.name!
    let imageFileURL = URL(fileURLWithPath: imageFilePath)
    
    do {
      try UIImageJPEGRepresentation(scaledImage!, 0.7)?.write(to: imageFileURL, options: .atomic)
    } catch {
      print(error.localizedDescription)
    }
    
    let imageAsset = CKAsset(fileURL: imageFileURL)
    restRecord.setValue(imageAsset, forKey: "image")
    let publicDataBase = CKContainer.default().publicCloudDatabase
    publicDataBase.save(restRecord) { (record, error) in
      guard error == nil else {
        print(error!.localizedDescription)
        return
      }
      
      do {
        try FileManager.default.removeItem(at: imageFileURL)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    yesButton.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    noButton.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    dismiss(animated: true, completion: nil)
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if indexPath.row == 0 {
      let alertController = UIAlertController(title: NSLocalizedString("Источник фотографии", comment: "Источник фотографии"), message: nil, preferredStyle: .actionSheet)
      let cameraAction = UIAlertAction(title: NSLocalizedString("Камера", comment: "Камера"), style: .default, handler: { (action) in
        self.chooseImagePickerAction(source: .camera)
      })
      let photoLibAction = UIAlertAction(title: NSLocalizedString("Фото", comment: "Фото"), style: .default, handler: { (action) in
        self.chooseImagePickerAction(source: .photoLibrary)
      })
      let cancelAction = UIAlertAction(title: NSLocalizedString("Отмена", comment: "Отмена"), style: .cancel, handler: nil)
      alertController.addAction(cameraAction)
      alertController.addAction(photoLibAction)
      alertController.addAction(cancelAction)
      self.present(alertController, animated: true, completion: nil)
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func chooseImagePickerAction(source: UIImagePickerControllerSourceType) {
    if UIImagePickerController.isSourceTypeAvailable(source) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.allowsEditing = true
      imagePicker.sourceType = source
      self.present(imagePicker, animated: true, completion: nil)
    }
  }
  
  /*
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
   
   // Configure the cell...
   
   return cell
   }
   */
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
