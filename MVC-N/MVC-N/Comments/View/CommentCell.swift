//
//  CommentCell.swift
//  MVC-N
//
//  Created by Ivan Akulov on 21/10/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    func configure(with comment: Comment) {
        self.label.text = comment.name
        self.textView.text = comment.body
    }
}
