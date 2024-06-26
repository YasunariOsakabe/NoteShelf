//
//  AddNoteView.swift
//  NoteShelf
//
//  Created by 小坂部泰成 on 2024/06/22.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var noteViewModel: NoteViewModel

    var body: some View {
        NavigationView {
            Form {
                TextField("メモ内容", text: $noteViewModel.content)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                TextField("タグ（カンマ区切り）", text: $noteViewModel.tags)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                if let image = noteViewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                Button("画像を選択") {
                    noteViewModel.showImagePicker = true
                }
                .foregroundColor(.blue)
            }
            .navigationTitle("メモを追加")
            .navigationBarItems(leading: Button("キャンセル") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("保存") {
                noteViewModel.addNote()
                presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $noteViewModel.showImagePicker) {
                ImagePicker(selectedImage: $noteViewModel.selectedImage)
            }
        }
    }
}
