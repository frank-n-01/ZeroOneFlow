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
    @StateObject var snow = SnowViewModel()
    @StateObject var wave = WaveViewModel()
    
    @State private var isFlowing: Bool = false {
        didSet {
            viewModel.isFlowing = isFlowing
        }
    }
    @State private var showControlSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                currentFlow
                
                if !isFlowing {
                    // The overlay to increase the visibility of tool bar buttons.
                    LinearGradient(colors: [viewModel.colors.bg, .black],
                                   startPoint: .top, endPoint: .bottom)
                        .opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                }
            }
            .onTapGesture {
                // Start the flow.
                isFlowing.toggle()
                if isFlowing && mode.isRandomStyle {
                    viewModel.makeRandomStyle()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    if !isFlowing {
                        HStack {
                            ModeButton(mode: $mode.flowMode)
                            Spacer()
                            RandomStyleButton()
                            Spacer()
                            ShowStyleButton(viewModel: viewModel)
                            Spacer()
                            ShowControlButton(isSheetPresent: $showControlSheet)
                        }
                    }
                }
            }
            .sheet(isPresented: $showControlSheet) {
                NavigationView {
                    Form {
                        currentHome
                    }
                    .navigationTitle(mode.flowMode.name)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            StyleNavigationButton(viewModel: viewModel,
                                                  isPresent: $showControlSheet)
                            Spacer()
                            PlayButton {
                                // Start without making random style.
                                showControlSheet.toggle()
                                isFlowing.toggle()
                            }
                            Spacer()
                            ResetButton(reset: viewModel.resetUserDefaults)
                        }
                    }
                }
                .navigationViewStyle(.stack)
            }
            .navigationBarHidden(true)
            .statusBar(hidden: isFlowing)
        }
        .navigationViewStyle(.stack)
        .onChange(of: viewModel.isFlowing) { newState in
            guard isFlowing != newState else { return }
            // Synchronize the state.
            isFlowing = newState
        }
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
        case .snow:
            return snow
        case .wave:
            return wave
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
            case .snow:
                SnowHome(snow: snow)
            case .wave:
                WaveHome(wave: wave)
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
            case .snow:
                SnowFlow(snow: snow)
            case .wave:
                WaveFlow(wave: wave)
            }
        }
    }
}
