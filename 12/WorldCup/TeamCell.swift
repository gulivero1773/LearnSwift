//
//  TeamCell.swift
//  WorldCup
//
//  Created by Sergey Dunaev on 11/01/2019.
//  Copyright © 2019 SwiftLab. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        teamLabel.text = nil
        scoreLabel.text = nil
        flagImageView.image = nil
    }
}
