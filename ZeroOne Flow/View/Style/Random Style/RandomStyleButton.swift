// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct RandomStyleButton: View {
    @EnvironmentObject var mode: ModeUserDefaults
    @State private var image = "die.face.1"
    var makeRandomStyle: () -> Void
    
    var body: some View {
        Button(action: { mode.isRandomStyle.toggle() }) {
            Image(systemName: self.image)
                .font(.title2)
        }
        .onAppear {
            throwDice()
        }
        .onChange(of: mode.isRandomStyle) { isOn in
            throwDice()
            if isOn {
                makeRandomStyle()
            }
        }
        .padding()
    }
    
    func throwDice() {
        self.image = "die.face.\(Int.random(in: 1...6))"
        
        if mode.isRandomStyle {
            self.image += ".fill"
        }
    }
}
