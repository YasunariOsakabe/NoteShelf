//
//  Book.swift
//  NoteShelf
//
//  Created by 小坂部泰成 on 2024/06/22.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let genre: String
    let notes: [Note]
    let dateAdded: Date
}
