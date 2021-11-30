// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct ModePicker: View {
    @Binding var mode: Mode
    
    var body: some View {
        Picker(selection: $mode) {
            ForEach(Mode.allCases) { mode in
                Text(mode.name)
                    .font(.title3)
                    .tag(mode)
            }
        } label: {
            HStack {
                Image(systemName: "dial.min.fill")
                    .foregroundColor(.gray)
                Text("Mode")
                    .bold()
            }
            .font(.title3)
        }
    }
}
