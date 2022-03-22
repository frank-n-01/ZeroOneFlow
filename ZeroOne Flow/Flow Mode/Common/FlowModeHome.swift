// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct FlowModeHome: View {
    @EnvironmentObject var mode: ModeUserDefaults
    @StateObject var linear = LinearViewModel()
    @StateObject var fly = FlyViewModel()
    @StateObject var tornado = TornadoViewModel()
    @StateObject var single = SingleViewModel()
    @StateObject var circle = CircleViewModel()
    @StateObject var worm = WormViewModel()
    @StateObject var bigbang = BigBangViewModel()
    @StateObject var rain = RainViewModel()
    
    @State private var isFlowing: Bool = false {
        didSet {
            viewModel.isFlowing = isFlowing
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                flowView
                homeView
            }
            .toolbar {
                bottomBarButtons
            }
            .onTapGesture(count: 2) {
                startFlow()
            }
            .navigationTitle("Control")
        }
        .navigationViewStyle(.stack)
    }
    
    var homeView: some View {
        Form {
            Section {
                ModePicker(mode: $mode.flowMode)
                styleViewLink
            }
            currentHome
        }
        .onAppear {
            // Enable the navigate animation after the home has appeared.
            UINavigationBar.setAnimationsEnabled(true)
        }
    }
    
    var styleViewLink: some View {
        NavigationLink {
            CoreDataStyleView(viewModel: viewModel)
        } label: {
            HStack {
                Image(systemName: "doc.on.doc")
                    .foregroundColor(.gray)
                Text("Style")
                    .bold()
                    .padding(.leading, 1)
            }
            .font(CommonStyles.labelFont)
            .padding(.leading, 2)
        }
    }
    
    var flowView: some View {
        NavigationLink(isActive: $isFlowing) {
            currentFlow
                .navigationBarHidden(isFlowing)
                .statusBar(hidden: isFlowing)
                .onTapGesture {
                    isFlowing.toggle()
                }
        } label: {
            EmptyView()
        }
        .onChange(of: isFlowing) { _ in
            if isFlowing {
                // dismiss the navigate animation when the flow starts.
                UINavigationBar.setAnimationsEnabled(false)
            }
        }
    }
    
    var bottomBarButtons: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            if !isFlowing {
                HStack {
                    RandomStyleButton()
                    Spacer()
                    SimpleImageButton(image: "play.fill", action: startFlow)
                    Spacer()
                    ResetButton(reset: viewModel.resetUserDefaults)
                }
            }
        }
    }
    
    func startFlow() {
        isFlowing.toggle()
        
        if mode.isRandomStyle {
            viewModel.makeRandomStyle()
        }
        
        ContentMaker.reset()
    }
    
    var viewModel: FlowModeViewModel {
        switch mode.flowMode {
        case .linear:
            return linear
        case .fly:
            return fly
        case .tornado:
            return tornado
        case .single:
            return single
        case .circle:
            return circle
        case .worm:
            return worm
        case .bigbang:
            return bigbang
        case .rain:
            return rain
        }
    }
    
    var currentHome: some View {
        Group {
            switch mode.flowMode {
            case .linear:
                LinearHome(linear: linear)
            case .fly:
                FlyHome(fly: fly)
            case .tornado:
                TornadoHome(tornado: tornado)
            case .single:
                SingleHome(single: single)
            case .circle:
                CircleHome(circle: circle)
            case .worm:
                WormHome(worm: worm)
            case .bigbang:
                BigBangHome(bigbang: bigbang)
            case .rain:
                RainHome(rain: rain)
            }
        }
    }
    
    var currentFlow: some View {
        Group {
            switch mode.flowMode {
            case .linear:
                LinearFlow(linear: linear)
            case .fly:
                FlyFlow(fly: fly)
            case .tornado:
                TornadoFlow(tornado: tornado)
            case .single:
                SingleFlow(single: single)
            case .circle:
                CircleFlow(circle: circle)
            case .worm:
                WormFlow(worm: worm)
            case .bigbang:
                BigBangFlow(bigbang: bigbang)
            case .rain:
                RainFlow(rain: rain)
            }
        }
    }
}
