// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct SaveStyleField: View {
    var saveCoreData: (String) -> Void
    @State private var showAlert = false
    @State private var name = ""
    
    var body: some View {
        HStack(spacing: 10) {
            TextField("style name", text: $name)
                .autocapitalization(.none)
            
            saveButton
        }
    }
    
    private var saveButton: some View {
        Button(action: { showAlert.toggle() }) {
            Image(systemName: "tray.and.arrow.down.fill")
                .font(CommonStyle.LABEL_FONT)
        }
        .alert("Save", isPresented: $showAlert) {
            Button("Cancel", role: .cancel) {}
            Button("OK", action: save)
        } message: {
            Text("save.message")
        }
    }
    
    func save() {
        if name.isEmpty {
            name = "unnamed"
        }
        
        saveCoreData(name)
        name = ""
    }
}
