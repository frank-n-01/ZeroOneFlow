// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct BackgroundColorView: View {
    @Binding var colors: Colors
    
    var body: some View {
        HStack {
            Text("Background")
                .font(CommonStyle.LABEL_FONT)
            Spacer()
            ColorPicker("", selection: $colors.bg)
                .frame(width: 45.0)
                .padding(.leading, -10)
        }
    }
}
