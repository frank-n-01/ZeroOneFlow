// Copyright © 2021 Ni Fu. All rights reserved.

import XCTest
@testable import ZeroOne_Flow

/// Test the current style of each flow mode are saved correctly.
class UserDefaultsTest: XCTestCase {
    
    /// Assert Equal of the common properties.
    func assertEqual(viewModel: FlowModeViewModel, with random: FlowModeViewModel) {
        XCTAssertEqual(viewModel.fonts, random.fonts)
        XCTAssertEqual(viewModel.colors, random.colors)
        XCTAssertEqual(viewModel.contents, random.contents)
    }
    
    func test01_Mode() {
        // Preserve the current state.
        var ud = ModeUserDefaults()
        let preserved = ud.flowMode
        let isRandomStyle = !ud.isRandomStyle
        
        // Set a random mode and check if the mode has been saved.
        let mode = Mode.allCases.randomElement()!
        ud.flowMode = mode
        ud.isRandomStyle = isRandomStyle
        ud = ModeUserDefaults()
        
        XCTAssertEqual(ud.flowMode, mode)
        XCTAssertEqual(ModeUserDefaults.sharedCurrentMode, mode.rawValue)
        XCTAssertEqual(ud.isRandomStyle, isRandomStyle)
        
        // Reset the change.
        ud.flowMode = preserved
    }
    
    func test02_Linear() {
        // Save the test data and check if it has been saved correctly.
        let random = LinearViewModel()
        random.makeRandomStyle()
        let linear = LinearViewModel()
        
        assertEqual(viewModel: linear, with: random)
        XCTAssertEqual(linear.interval, random.interval)
        XCTAssertEqual(linear.isRepeat, random.isRepeat)
        XCTAssertEqual(linear.linefeed, random.linefeed)
        XCTAssertEqual(linear.indents, random.indents)
        
        // Clear the changes.
        linear.resetUserDefaults()
    }
    
    
    func test03_Fly() {
        // Save the test data and check if it has been saved correctly.
        let random = FlyViewModel()
        random.makeRandomStyle()
        let fly = FlyViewModel()
        
        assertEqual(viewModel: fly, with: random)
        XCTAssertEqual(fly.interval, random.interval)
        XCTAssertEqual(fly.scale, random.scale)
        XCTAssertEqual(fly.padding, random.padding)

        // Clear the changes.
        fly.resetUserDefaults()
    }
    
    func test04_Tornado() {
        // Save the test data and check if it has been saved correctly.
        let random = TornadoViewModel()
        random.makeRandomStyle()
        let tornado = TornadoViewModel()
        
        assertEqual(viewModel: tornado, with: random)
        XCTAssertEqual(tornado.scale, random.scale)
        XCTAssertEqual(tornado.durationRange, random.durationRange)
        XCTAssertEqual(tornado.angleRange, random.angleRange)

        // Clear the changes.
        tornado.resetUserDefaults()
    }
    
    func test05_Single() {
        // Save the test data and check if it has been saved correctly.
        let random = SingleViewModel()
        random.makeRandomStyle()
        let single = SingleViewModel()
        
        assertEqual(viewModel: single, with: random)
        XCTAssertEqual(single.interval, random.interval)
        XCTAssertEqual(single.gradientType, random.gradientType)

        // Clear the changes.
        single.resetUserDefaults()
    }
    
    func test06_Circle() {
        // Save the test data and check if it has been saved correctly.
        let random = CircleViewModel()
        random.makeRandomStyle()
        let circle = CircleViewModel()
        
        assertEqual(viewModel: circle, with: random)
        XCTAssertEqual(circle.interval, random.interval)
        XCTAssertEqual(circle.depth, random.depth)
        XCTAssertEqual(circle.gap, random.gap)
        XCTAssertEqual(circle.rotationAngle, random.rotationAngle)

        // Clear the changes.
        circle.resetUserDefaults()
    }
    
    func test07_Worm() {
        // Save the test data and check if it has been saved correctly.
        let random = WormViewModel()
        random.makeRandomStyle()
        let worm = WormViewModel()
        
        assertEqual(viewModel: worm, with: random)
        XCTAssertEqual(worm.interval, random.interval)
        XCTAssertEqual(worm.length, random.length)
        XCTAssertEqual(worm.step, random.step)
        XCTAssertEqual(worm.crawling, random.crawling)
        XCTAssertEqual(worm.padding, random.padding)

        // Clear the changes.
        worm.resetUserDefaults()
    }
    
    func test08_BigBang() {
        // Save the test data and check if it has been saved correctly.
        let random = BigBangViewModel()
        random.makeRandomStyle()
        let bigbang = BigBangViewModel()
        
        assertEqual(viewModel: bigbang, with: random)
        XCTAssertEqual(bigbang.scale, random.scale)
        XCTAssertEqual(bigbang.interval, random.interval)
        XCTAssertEqual(bigbang.gap, random.gap)
        XCTAssertEqual(bigbang.rotationAngle, random.rotationAngle)
        XCTAssertEqual(bigbang.padding, random.padding)
        XCTAssertEqual(bigbang.is3D, random.is3D)

        // Clear the changes.
        bigbang.resetUserDefaults()
    }
    
    func test09_Rain() {
        // Save the test data and check if it has been saved correctly.
        let random = RainViewModel()
        random.makeRandomStyle()
        let rain = RainViewModel()
        
        assertEqual(viewModel: rain, with: random)
        XCTAssertEqual(rain.scale, random.scale)
        XCTAssertEqual(rain.interval, random.interval)
        XCTAssertEqual(rain.length, random.length)
        XCTAssertEqual(rain.step, random.step)

        // Clear the changes.
        rain.resetUserDefaults()
    }
}
