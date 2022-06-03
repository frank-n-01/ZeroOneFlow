// Copyright © 2022 Ni Fu. All rights reserved.

import SwiftUI

struct ModeButton: View {
    @Binding var mode: Mode
    
    var body: some View {
        Menu {
            Picker("", selection: $mode) {
                ForEach(Mode.allCases) { mode in
                    HStack {
                        Text(mode.name)
                        Image(systemName: mode.image)
                    }
                    .tag(mode)
                }
            }
        } label: {
            Image(systemName: mode.image)
                .font(CommonStyle.LABEL_FONT)
        }
        .padding()
    }
}
