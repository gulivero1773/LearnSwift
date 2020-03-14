//
//  NoteImageTableViewCell.swift
//  UnCloudNotes
//
//  Created by Sergey Dunaev on 15/01/2019.
//  Copyright © 2019 SwiftLab. All rights reserved.
//

import UIKit

class NoteImageTableViewCell: NoteTableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet fileprivate var noteImage: UIImageView!
}

// MARK: - Internal
extension NoteImageTableViewCell {
    
    override func updateNoteInfo(note: Note) {
        super.updateNoteInfo(note: note)
        noteImage.image = note.image
    }
}


