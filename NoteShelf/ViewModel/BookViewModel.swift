//
//  BookViewModel.swift
//  NoteShelf
//
//  Created by 小坂部泰成 on 2024/06/22.
//

import SwiftUI
import Combine

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var searchText = ""
    @Published var sortOption: SortOption = .title
    
    var filteredBooks: [Book] {
        let sortedBooks = books.sorted {
            switch sortOption {
            case .title:
                return $0.title < $1.title
            case .genre:
                return $0.genre < $1.genre
            case .date:
                return $0.dateAdded < $1.dateAdded
            }
        }
        
        if searchText.isEmpty {
            return sortedBooks
        } else {
            return sortedBooks.filter { $0.title.contains(searchText) || $0.genre.contains(searchText) || $0.notes.contains { $0.content.contains(searchText) || $0.tags.contains { $0.contains(searchText) } } }
        }
    }
    
    func addBook(_ book: Book) {
        books.append(book)
    }
    
    func deleteBook(at offsets: IndexSet) {
        books.remove(atOffsets: offsets)
    }
}
