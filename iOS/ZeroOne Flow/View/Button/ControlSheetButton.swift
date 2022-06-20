// Copyright © 2022 Ni Fu. All rights reserved.

import SwiftUI

struct ControlSheetButton: View {
    @Binding var isSheetPresent: Bool
    
    var body: some View {
        Button {
            isSheetPresent.toggle()
        } label: {
            Image(systemName: "ellipsis.circle.fill")
        }
        .font(CommonStyle.LABEL_FONT)
        .padding()
    }
}
