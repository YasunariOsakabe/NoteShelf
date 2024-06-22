//
//  AddBookView.swift
//  NoteShelf
//
//  Created by 小坂部泰成 on 2024/06/22.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var bookViewModel: BookViewModel
    @State private var title = ""
    @State private var genre = ""
    @StateObject private var noteViewModel = NoteViewModel()
    @State private var showAddNoteView = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("本の情報")) {
                    TextField("タイトル", text: $title)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    TextField("ジャンル", text: $genre)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }

                Section(header: Text("メモ")) {
                    ForEach(noteViewModel.notes) { note in
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
                    .onDelete(perform: noteViewModel.deleteNote)

                    Button(action: {
                        showAddNoteView = true
                    }) {
                        Text("メモを追加")
                            .font(.body)
                            .foregroundColor(.blue)
                    }
                    .sheet(isPresented: $showAddNoteView) {
                        AddNoteView(noteViewModel: noteViewModel)
                    }
                }
            }
            .navigationTitle("本を追加")
            .navigationBarItems(leading: Button("キャンセル") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("保存") {
                let newBook = Book(title: title, genre: genre, notes: noteViewModel.notes, dateAdded: Date())
                bookViewModel.addBook(newBook)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
