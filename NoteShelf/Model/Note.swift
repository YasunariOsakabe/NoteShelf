//
//  Note.swift
//  NoteShelf
//
//  Created by 小坂部泰成 on 2024/06/22.
//

import UIKit

struct Note: Identifiable {
    let id = UUID()
    let content: String
    let tags: [String]
    let image: UIImage?
    let dateAdded: Date
}
