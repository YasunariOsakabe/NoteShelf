//
//  AddReminderView.swift
//  NoteShelf
//
//  Created by 小坂部泰成 on 2024/06/22.
//

import SwiftUI

struct AddReminderView: View {
    let book: Book
    @Environment(\.presentationMode) var presentationMode
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("リマインダー日時", selection: $date, displayedComponents: .date)
            }
            .navigationTitle("リマインダーを追加")
            .navigationBarItems(leading: Button("キャンセル") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("保存") {
                // リマインダー保存処理をここに追加
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
