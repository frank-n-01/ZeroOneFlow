// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct SaveStyleView: View {
    var saveCoreData: (String) -> Void
    @State private var showAlert = false
    @StateObject private var styleName = StyleName()
    
    var body: some View {
        HStack(spacing: 10) {
            styleNameTextField
            saveButton
        }
    }
    
    private var styleNameTextField: some View {
        TextField("style name", text: $styleName.name)
            .autocapitalization(.none)
    }
    
    private var saveButton: some View {
        Button(action: { showAlert.toggle() }) {
            Image(systemName: "tray.and.arrow.down.fill")
                .font(.title3)
        }
        .alert("Save", isPresented: $showAlert) {
            Button("Cancel", role: .cancel) {}
            Button("OK", action: save)
        } message: {
            Text("save.message")
        }
    }
    
    private func save() {
        if styleName.name.isEmpty {
            styleName.name = "unnamed"
        }
        
        saveCoreData(styleName.name)
        styleName.name = ""
    }
}
