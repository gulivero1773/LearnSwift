//
//  AboutTableViewController.swift
//  Eateries
//
//  Created by Ivan Akulov on 08/10/2016.
//  Copyright © 2016 Ivan Akulov. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {
  
  let sectionsHeaders = ["Мы в социальных сетях", "Наши сайты"]
  let sectionsContent = [["facebook", "vk", "youtube"], ["swiftbook.ru", "forum.swiftbook.ru"]]
  let firstSectionLinks = ["https://www.facebook.com/swiftbook.ru/", "https://vk.com/swiftbook", "https://www.youtube.com/channel/UCXlCPCsB09ftBA5bQfiSWoQ"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.tableFooterView = UIView(frame: .zero)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return sectionsHeaders.count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionsHeaders[section]
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return sectionsContent[section].count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = sectionsContent[indexPath.section][indexPath.row]
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    switch indexPath.section {
      case 0:
        switch indexPath.row {
        case 0..<firstSectionLinks.count:
          performSegue(withIdentifier: "showWebPageSegue", sender: self)
        default: break
        }
      default: break
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showWebPageSegue" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let dvc = segue.destination as! WebViewController
        dvc.url = URL(string: firstSectionLinks[indexPath.row])
      }
    }
  }
}
