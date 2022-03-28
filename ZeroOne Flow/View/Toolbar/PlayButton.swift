// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct PlayButton: View {
    let play: () -> Void
    
    var body: some View {
        Button(action: play) {
            Image(systemName: "play.fill")
                .font(CommonStyle.TOOLBAR_BUTTON_FONT)
        }
        .padding()
    }
}
