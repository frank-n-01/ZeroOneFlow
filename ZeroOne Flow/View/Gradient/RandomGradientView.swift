// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct RandomGradientView: View {
    @Binding var colors: Colors
    @Binding var gradientType: GradientType
    
    var body: some View {
        typePicker
        activateToggle
    }
    
    private var typePicker: some View {
        Picker(selection: $gradientType) {
            ForEach(0 ..< GradientType.allCases.count, id: \.self) { i in
                Text(GradientType.allCases[i].name)
                    .tag(GradientType.allCases[i])
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
