//
//  AppStorageView.swift
//  StorageDemo
//
//  Created by seokyung on 4/22/24.
//

import SwiftUI

struct AppStorageView: View {
    @AppStorage("mytext") private var editorText: String = "Sample Text"
    var body: some View {
        TextEditor(text: $editorText)
            .padding()
            .font(.largeTitle)
    }
}

#Preview {
    AppStorageView()
}
