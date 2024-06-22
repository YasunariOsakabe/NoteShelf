//
//  ContentView.swift
//  NoteShelf
//
//  Created by 小坂部泰成 on 2024/06/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var bookViewModel = BookViewModel()
    @State private var showAddBookView = false

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $bookViewModel.searchText)
                
                Picker("ソート", selection: $bookViewModel.sortOption) {
                    ForEach(SortOption.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List {
                    ForEach(bookViewModel.filteredBooks) { book in
                        NavigationLink(destination: BookDetailView(book: book, bookViewModel: bookViewModel)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .font(.headline)
                                    Text(book.genre)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Text(book.dateAdded, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                        }
                        .padding(.vertical, 5)
                    }
                    .onDelete(perform: bookViewModel.deleteBook)
                }
                .navigationTitle("NoteShelf")
                .navigationBarItems(trailing: Button(action: {
                    showAddBookView = true
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                })
                .sheet(isPresented: $showAddBookView) {
                    AddBookView(bookViewModel: bookViewModel)
                }
            }
            .background(Color(.systemGray6))
        }
    }
}
