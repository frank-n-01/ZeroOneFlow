// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct BackgroundColorView: View {
    @Binding var colors: Colors
    
    var body: some View {
        HStack {
            Text("Background")
                .font(.title3)
            Spacer()
            ColorPicker("", selection: $colors.bg)
                .frame(width: 45.0)
                .padding(.leading, -10)
        }
    }
}
