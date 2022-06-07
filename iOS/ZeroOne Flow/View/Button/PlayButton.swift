// Copyright © 2022 Ni Fu. All rights reserved.

import SwiftUI

struct PlayButton: View {
    var play: () -> Void
    
    var body: some View {
        Button {
            play()
        } label: {
            Image(systemName: "play.fill")
                .font(CommonStyle.LABEL_FONT)
                .padding()
        }
    }
}
