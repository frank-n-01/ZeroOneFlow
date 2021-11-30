// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct ColorView: View {
    @Binding var colors: Colors
    let random: Bool
    
    var body: some View {
        Section {
            TextColorView(colors: $colors)
            BackgroundColorView(colors: $colors)
        } header: {
            Text("Color")
        }
    }
}
