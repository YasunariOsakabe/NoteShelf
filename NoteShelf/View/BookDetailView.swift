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
                    .font(.title3)
            }
            
            Section(header: Text("メモ")) {
                ForEach(book.notes) { note in
                    VStack(alignment: .leading) {
                        Text(note.content)
                            .font(.body)
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
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                    .padding(.vertical, 5)
                }
            }
            
            Button("リマインダーを追加") {
                showAddReminderView = true
            }
            .foregroundColor(.blue)
            .sheet(isPresented: $showAddReminderView) {
                AddReminderView(book: book)
            }

            Button("メモをエクスポート") {
                showExportSheet = true
            }
            .foregroundColor(.blue)
            .sheet(isPresented: $showExportSheet) {
                ExportSheet(book: book)
            }
        }
        .navigationTitle(book.title)
    }
}
