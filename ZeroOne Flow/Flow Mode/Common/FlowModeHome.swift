// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

struct FlowModeHome: View {
    @EnvironmentObject var modeUD: ModeUserDefaults
    // view models of each flow modes
    @StateObject var linear = LinearViewModel()
    @StateObject var fly = FlyViewModel()
    @StateObject var tornado = TornadoViewModel()
    @StateObject var single = SingleViewModel()
    @StateObject var circle = CircleViewModel()
    @StateObject var worm = WormViewModel()
    @StateObject var bigbang = BigBangViewModel()
    @StateObject var rain = RainViewModel()
    @StateObject var geometry = GeometryViewModel()
    // start the flow
    @State private var start: Bool = false {
        didSet {
            viewModel.start = start
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
                ModePicker(mode: $modeUD.mode)
                styleLink
            }
            // Each flow mode's control views.
            homeSwitch
        }
        .onAppear {
            UINavigationBar.setAnimationsEnabled(true)
        }
    }
    
    var styleLink: some View {
        NavigationLink {
            CoreDataStyleList(viewModel: viewModel)
        } label: {
            HStack {
                Image(systemName: "doc.on.doc")
                    .foregroundColor(.gray)
                Text("My Styles")
                    .bold()
                    .padding(.leading, 1)
            }
            .font(.title3)
            .padding(.leading, 2)
        }
    }
    
    var flowView: some View {
        NavigationLink(isActive: $start) {
            flowSwitch
                .navigationBarHidden(start)
                .statusBar(hidden: start)
                .onTapGesture {
                    start.toggle()
                }
        } label: {
            EmptyView()
        }
        .onChange(of: start) { _ in
            if start {
                UINavigationBar.setAnimationsEnabled(false)
            }
        }
    }
    
    var bottomBarButtons: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            if !start {
                HStack {
                    RandomStyleButton(viewModel: viewModel)
                    Spacer()
                    SimpleImageButton(image: "play.fill", action: startFlow)
                        .accessibilityIdentifier("play")
                    Spacer()
                    ResetButton(reset: viewModel.resetUserDefaults)
                }
            }
        }
    }
    
    func startFlow() {
        start.toggle()
        viewModel.makeRandomStyle()
    }
    
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
        case .geometry:
            return geometry
        }
    }
    
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
            case .geometry:
                GeometryHome(geometry: geometry)
            }
        }
    }
    
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
            case .geometry:
                GeometryFlow(geometry: geometry)
            }
        }
    }
}
