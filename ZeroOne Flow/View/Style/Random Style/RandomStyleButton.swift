// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct RandomStyleButton: View {
    @ObservedObject var viewModel: FlowModeViewModel
    @State private var image = "die.face.1"
    @State private var showAlert = false
    
    var body: some View {
        Button(action: {
            if !viewModel.isRandomStyle {
                showAlert.toggle()
            } else {
                viewModel.isRandomStyle.toggle()
            }
        }) {
            Image(systemName: image)
                .font(.title2)
                .padding()
        }
        .onAppear {
            throwDice()
        }
        .onChange(of: viewModel.isRandomStyle) { _ in
            throwDice()
        }
        .alert("Random Style", isPresented: $showAlert) {
            Button("Cancel", role: .cancel) {}
            Button("OK", action: { viewModel.isRandomStyle.toggle() })
        } message: {
            Text("random-style.message")
        }
    }
    
    func throwDice() {
        image = "die.face.\(Int.random(in: 1...6))"
        
        if viewModel.isRandomStyle {
            image += ".fill"
        }
    }
}
