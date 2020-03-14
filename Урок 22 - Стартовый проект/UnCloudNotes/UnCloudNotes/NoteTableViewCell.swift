//
//  NoteTableViewCell.swift
//  UnCloudNotes
//
//  Created by Sergey Dunaev on 15/01/2019.
//  Copyright © 2019 SwiftLab. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var note: Note? {
        didSet {
            guard let note = note else { return }
            updateNoteInfo(note: note)
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet fileprivate var noteTitle: UILabel!
    @IBOutlet fileprivate var noteCreateDate: UILabel!
}

// MARK: - Internal
@objc extension NoteTableViewCell {
    
    func updateNoteInfo(note: Note) {
        noteTitle.text = note.title
        noteCreateDate.text = note.dateCreated.description
    }
}
