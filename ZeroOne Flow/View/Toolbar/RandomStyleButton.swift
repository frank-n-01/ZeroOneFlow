// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct RandomStyleButton: View {
    @EnvironmentObject var mode: ModeUserDefaults
    @State private var image = "die.face.1"
    
    var body: some View {
        Button(action: { mode.isRandomStyle.toggle() }) {
            Image(systemName: self.image)
                .font(CommonStyle.TOOLBAR_BUTTON_FONT)
        }
        .onAppear {
            throwDice()
        }
        .onChange(of: mode.isRandomStyle) { isOn in
            throwDice()
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
