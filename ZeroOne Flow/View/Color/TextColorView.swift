// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct TextColorView: View {
    @Binding var colors: Colors
    
    var body: some View {
        HStack {
            Text("Text")
                .font(.title3)
            Spacer()
            Button(action: swap) {
                Image(systemName: "arrow.up.arrow.down")
                    .font(.title3)
            }
            ColorPicker("", selection: $colors.txt)
                .frame(width: 45.0)
                .padding(.leading, -10)
        }
    }
    
    private func swap() {
        let tmp = colors.txt
        colors.txt = colors.bg
        colors.bg = tmp
    }
}
