//
//  BookDetailView.swift
//  NoteShelf
//
//  Created by 小坂部泰成 on 2024/06/22.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book
    @ObservedObject var bookViewModel: BookViewModel
    @State private var showAddReminderView = false
    @State private var showExportSheet = false
    
    var body: some View {
        List {
            Section(header: Text("ジャンル")) {
                Text(book.genre)
            }
            
            Section(header: Text("メモ")) {
                ForEach(book.notes) { note in
                    VStack(alignment: .leading) {
                        Text(note.content)
                        ForEach(note.tags, id: \.self) { tag in
                            Text("#\(tag)")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        if let image = note.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                        }
                    }
                }
            }
            
            Button("リマインダーを追加") {
                showAddReminderView = true
            }
            .sheet(isPresented: $showAddReminderView) {
                AddReminderView(book: book)
            }

            Button("メモをエクスポート") {
                showExportSheet = true
            }
            .sheet(isPresented: $showExportSheet) {
                ExportSheet(book: book)
            }
        }
        .navigationTitle(book.title)
    }
}
