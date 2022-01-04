// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct FlowModeHome: View {
    @EnvironmentObject var modeUD: ModeUserDefaults
    
    // View models of each flow mode.
    @StateObject var linear = LinearViewModel()
    @StateObject var fly = FlyViewModel()
    @StateObject var tornado = TornadoViewModel()
    @StateObject var single = SingleViewModel()
    @StateObject var circle = CircleViewModel()
    @StateObject var worm = WormViewModel()
    @StateObject var bigbang = BigBangViewModel()
    @StateObject var rain = RainViewModel()
    
    /// Start the flow in the home view.
    ///
    /// The state is shared with the view model's `isFlowing` property.
    @State private var start: Bool = false {
        didSet {
            viewModel.isFlowing = start
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
    
    /// Control the style of flow.
    var homeView: some View {
        Form {
            Section {
                ModePicker(mode: $modeUD.mode)
                styleLink
            }
            homeSwitch
        }
        .onAppear {
            // Enable the navigate animation after the home has appeared.
            UINavigationBar.setAnimationsEnabled(true)
        }
    }
    
    /// Save and apply the styles.
    var styleLink: some View {
        NavigationLink {
            CoreDataStyleList(viewModel: viewModel)
        } label: {
            HStack {
                Image(systemName: "doc.on.doc")
                    .foregroundColor(.gray)
                Text("Style")
                    .bold()
                    .padding(.leading, 1)
            }
            .font(.title3)
            .padding(.leading, 2)
        }
    }
    
    /// Play the flow animation.
    var flowView: some View {
        NavigationLink(isActive: $start) {
            flowSwitch
                .navigationBarHidden(start)
                .statusBar(hidden: start)
                .onTapGesture {
                    // Finish the flow.
                    start.toggle()
                }
        } label: {
            EmptyView()
        }
        .onChange(of: start) { _ in
            if start {
                // dismiss the navigate animation when the flow starts.
                UINavigationBar.setAnimationsEnabled(false)
            }
        }
    }
    
    /// The buttons of the tool bar.
    var bottomBarButtons: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            if !start {
                HStack {
                    RandomStyleButton(viewModel: viewModel)
                    Spacer()
                    SimpleImageButton(image: "play.fill", action: startFlow)
                    Spacer()
                    ResetButton(reset: viewModel.resetUserDefaults)
                }
            }
        }
    }
    
    /// Start the flow.
    ///
    /// If the random style mode is activated, make a random style everytime.
    func startFlow() {
        start.toggle()
        viewModel.makeRandomStyle()
        ContentMaker.reset()
    }
    
    /// The current flow mode's view model.
    var viewModel: FlowModeViewModel {
        switch modeUD.mode {
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
    
    /// The current flow mode's home view.
    var homeSwitch: some View {
        Group {
            switch modeUD.mode {
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
    
    /// The current flow mode's flow view.
    var flowSwitch: some View {
        Group {
            switch modeUD.mode {
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
