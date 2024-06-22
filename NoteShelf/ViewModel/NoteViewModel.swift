//
//  NoteViewModel.swift
//  NoteShelf
//
//  Created by 小坂部泰成 on 2024/06/22.
//

import SwiftUI
import Combine

class NoteViewModel: ObservableObject {
    @Published var notes: [Note] = []
    @Published var content = ""
    @Published var tags: String = ""
    @Published var selectedImage: UIImage?
    @Published var showImagePicker = false

    func addNote() {
        let tagList = tags.split(separator: ",").map { String($0) }
        let newNote = Note(content: content, tags: tagList, image: selectedImage, dateAdded: Date())
        notes.append(newNote)
    }
    
    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
}
