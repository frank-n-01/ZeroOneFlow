// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct RandomGradientView: View {
    @Binding var colors: Colors
    @Binding var type: GradientType
    
    var body: some View {
        typePicker
        activateToggle
    }
    
    private var typePicker: some View {
        Picker(selection: $type) {
            ForEach(0 ..< GradientType.allCases.count, id: \.self) { i in
                Text(GradientType.allCases[i].name)
                    .tag(GradientType.allCases[i])
                    .font(.title3)
            }
        } label: {
            Text("Type")
                .font(.title3)
        }
    }
    
    private var activateToggle: some View {
        Toggle(isOn: $colors.bgRandom) {
            Text("Activate")
                .font(.title3)
        }
    }
}
