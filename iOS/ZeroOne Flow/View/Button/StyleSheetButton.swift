// Copyright © 2022 Ni Fu. All rights reserved.

import SwiftUI

struct StyleSheetButton: View {
    @ObservedObject var viewModel: FlowModeViewModel
    @State private var isPresent = false
    
    var body: some View {
        Button {
            isPresent.toggle()
        } label: {
            Image(systemName: "doc")
                .font(CommonStyle.LABEL_FONT)
                .padding()
        }
        .sheet(isPresented: $isPresent) {
            StyleList(viewModel: viewModel, isPresent: $isPresent)
        }
    }
}
