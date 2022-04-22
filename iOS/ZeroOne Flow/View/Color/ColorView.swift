// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct ColorView: View {
    @Binding var colors: Colors
    
    var body: some View {
        Section {
            TextColorView(colors: $colors)
            BackgroundColorView(colors: $colors)
        } header: {
            Text("Color")
        }
    }
}
