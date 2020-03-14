//
//  NoteDetailViewController.swift
//  UnCloudNotes
//
//  Created by Sergey Dunaev on 15/01/2019.
//  Copyright © 2019 SwiftLab. All rights reserved.
//

import UIKit

protocol NoteDisplayable: class {
    var note: Note? { get set }
}

class NoteDetailViewController: UIViewController, NoteDisplayable {
    
    // MARK: - Properties
    var note: Note? {
        didSet {
            updateNoteInfo()
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet fileprivate var titleField: UILabel!
    @IBOutlet fileprivate var bodyField: UITextView!
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNoteInfo()
    }
}

// MARK: - Internal
extension NoteDetailViewController {
    
    func updateNoteInfo() {
        guard isViewLoaded,
            let note = note else {
                return
        }
        
        titleField.text = note.title
        bodyField.text = note.body
    }
}
