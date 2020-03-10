//
//  EateryDetailTableViewCell.swift
//  Eateries
//
//  Created by Ivan Akulov on 01/10/2016.
//  Copyright © 2016 Ivan Akulov. All rights reserved.
//

import UIKit

class EateryDetailTableViewCell: UITableViewCell {

  @IBOutlet weak var keyLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
