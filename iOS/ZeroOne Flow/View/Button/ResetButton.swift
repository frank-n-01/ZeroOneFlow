// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct ResetButton: View {
    @EnvironmentObject var mode: ModeUserDefaults
    let reset: () -> Void
    @State private var showAlert = false
    
    var body: some View {
        resetButton
            .alert("Reset", isPresented: $showAlert) {
                alertButtons
            } message: {
                Text("reset.message")
            }
            .padding()
    }
    
    var resetButton: some View {
        Button(action: { showAlert.toggle() }) {
            Image(systemName: "arrow.uturn.left")
                .font(CommonStyle.LABEL_FONT)
                .foregroundColor(.red)
        }
    }
    
    var alertButtons: some View {
        Group {
            Button("Cancel", role: .cancel, action: {})
            Button("OK", role: .destructive, action: {
                reset()
                mode.isRandomStyle = false
            })
        }
    }
}
