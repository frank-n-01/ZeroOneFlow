// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct RandomStyleButton: View {
    @EnvironmentObject var mode: ModeUserDefaults
    @State private var diceImage = "die.face.1"
    
    var body: some View {
        Button(action: { mode.isRandomStyle.toggle() }) {
            Image(systemName: mode.isRandomStyle ? diceImage + ".fill" : diceImage)
                .font(CommonStyle.LABEL_FONT)
        }
        .onAppear {
            diceImage = "die.face.\(Int.random(in: 1...6))"
        }
        .padding()
    }
}
