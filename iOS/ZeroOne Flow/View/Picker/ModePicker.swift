// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct ModePicker: View {
    @Binding var mode: Mode
    
    var body: some View {
        Picker(selection: $mode) {
            ForEach(Mode.allCases) { mode in
                Text(mode.name)
                    .font(CommonStyle.LABEL_FONT)
                    .tag(mode)
            }
        } label: {
            HStack {
                Image(systemName: "dial.min.fill")
                    .foregroundColor(.gray)
                Text("Mode")
                    .bold()
            }
            .font(CommonStyle.LABEL_FONT)
        }
    }
}
