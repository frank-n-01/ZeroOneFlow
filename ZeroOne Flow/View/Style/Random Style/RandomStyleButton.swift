// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct RandomStyleButton: View {
    @ObservedObject var viewModel: FlowModeViewModel
    @State private var image = "die.face.1"
    
    var body: some View {
        Button(action: { viewModel.isRandomStyle.toggle() }) {
            Image(systemName: self.image)
                .font(.title2)
        }
        .onAppear {
            throwDice()
        }
        .onChange(of: viewModel.isRandomStyle) { _ in
            throwDice()
        }
        .padding()
    }
    
    func throwDice() {
        self.image = "die.face.\(Int.random(in: 1...6))"
        
        if viewModel.isRandomStyle {
            self.image += ".fill"
        }
    }
}
