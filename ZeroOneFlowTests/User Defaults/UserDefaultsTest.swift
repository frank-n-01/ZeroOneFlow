// Copyright © 2021 Ni Fu. All rights reserved.

import XCTest
@testable import ZeroOne_Flow

/// Test the current style of each flow mode are saved correctly.
class UserDefaultsTest: XCTestCase {
    
    /// Assert the default value of common properties are set correctly.
    func assertDefault(viewModel: FlowModeViewModel, fonts: Fonts) {
        XCTAssertEqual(viewModel.flowModeUD.isSaved, true)
        XCTAssertEqual(viewModel.isRandomStyle, false)
        XCTAssertEqual(viewModel.fonts, fonts)
        XCTAssertEqual(viewModel.colors, Colors())
        XCTAssertEqual(viewModel.contents, Contents())
    }
    
    /// Assert Equal of the common properties.
    func assertEqual(viewModel: FlowModeViewModel, with random: FlowModeViewModel) {
        XCTAssertEqual(viewModel.isRandomStyle, random.isRandomStyle)
        XCTAssertEqual(viewModel.fonts, random.fonts)
        XCTAssertEqual(viewModel.colors, random.colors)
        XCTAssertEqual(viewModel.contents, random.contents)
    }
    
    func test01_Mode() {
        
        // Preserve the current state.
        var ud = ModeUserDefaults()
        let preserved = ud.mode
        
        // Set a random mode and check if the mode has been saved.
        let mode = Mode.allCases.randomElement()!
        ud.mode = mode
        ud = ModeUserDefaults()
        
        XCTAssertEqual(ud.mode, mode)
        XCTAssertEqual(ModeUserDefaults.currentMode, mode.rawValue)
        
        // Reset the change.
        ud.mode = preserved
    }

    func test02_Linear() {
        
        // Check if the default style has been saved.
        var linear = LinearViewModel()
        linear.applyUserDefaults()
        linear = LinearViewModel()
        
        assertDefault(viewModel: linear, fonts: linear.FONT)
        XCTAssertEqual(linear.interval, linear.INTERVAL)
        XCTAssertEqual(linear.repeatFlow, linear.REPEAT_FLOW)
        XCTAssertEqual(linear.linefeed, linear.LINEFEED)
        XCTAssertEqual(linear.indents, linear.INDENTS)
        
        // Save the test data and check if it has been saved correctly.
        let random = LinearViewModel()
        random.isRandomStyle = true
        random.makeRandomStyle()
        random.isRandomStyle = false
        linear = LinearViewModel()
        
        assertEqual(viewModel: linear, with: random)
        XCTAssertEqual(linear.interval, random.interval)
        XCTAssertEqual(linear.repeatFlow, random.repeatFlow)
        XCTAssertEqual(linear.linefeed, random.linefeed)
        XCTAssertEqual(linear.indents, random.indents)
        
        // Clear the changes.
        linear.resetUserDefaults()
    }
    
    
    func test03_Fly() {
        
        // Check if the default style has been saved.
        var fly = FlyViewModel()
        fly.resetUserDefaults()
        fly = FlyViewModel()
        
        assertDefault(viewModel: fly, fonts: fly.FONT)
        XCTAssertEqual(fly.interval, fly.INTERVAL)
        XCTAssertEqual(fly.scale, fly.SCALE)
        XCTAssertEqual(fly.padding, fly.PADDING)
        
        // Save the test data and check if it has been saved correctly.
        let random = FlyViewModel()
        random.isRandomStyle = true
        random.makeRandomStyle()
        random.isRandomStyle = false
        fly = FlyViewModel()
        
        assertEqual(viewModel: fly, with: random)
        XCTAssertEqual(fly.interval, random.interval)
        XCTAssertEqual(fly.scale, random.scale)
        XCTAssertEqual(fly.padding, random.padding)

        // Clear the changes.
        fly.resetUserDefaults()
    }
    
    func test04_Tornado() {
        
        // Check if the default style has been saved.
        var tornado = TornadoViewModel()
        tornado.resetUserDefaults()
        tornado = TornadoViewModel()
        
        assertDefault(viewModel: tornado, fonts: tornado.FONT)
        XCTAssertEqual(tornado.scale, tornado.SCALE)
        XCTAssertEqual(tornado.durationRange, tornado.DURATION)
        XCTAssertEqual(tornado.angleRange, tornado.ANGLE)
        
        // Save the test data and check if it has been saved correctly.
        let random = TornadoViewModel()
        random.isRandomStyle = true
        random.makeRandomStyle()
        random.isRandomStyle = false
        tornado = TornadoViewModel()
        
        assertEqual(viewModel: tornado, with: random)
        XCTAssertEqual(tornado.scale, random.scale)
        XCTAssertEqual(tornado.durationRange, random.durationRange)
        XCTAssertEqual(tornado.angleRange, random.angleRange)

        // Clear the changes.
        tornado.resetUserDefaults()
    }
    
    func test05_Single() {
        
        // Check if the default style has been saved.
        var single = SingleViewModel()
        single.resetUserDefaults()
        single = SingleViewModel()
        
        assertDefault(viewModel: single, fonts: single.FONT)
        XCTAssertEqual(single.interval, single.INTERVAL)
        XCTAssertEqual(single.gradientType, single.GRADIENT_TYPE)

        // Save the test data and check if it has been saved correctly.
        let random = SingleViewModel()
        random.isRandomStyle = true
        random.makeRandomStyle()
        random.isRandomStyle = false
        single = SingleViewModel()
        
        assertEqual(viewModel: single, with: random)
        XCTAssertEqual(single.interval, random.interval)
        XCTAssertEqual(single.gradientType, random.gradientType)

        // Clear the changes.
        single.resetUserDefaults()
    }
    
    func test06_Circle() {
        
        // Check if the default style has been saved.
        var circle = CircleViewModel()
        circle.resetUserDefaults()
        circle = CircleViewModel()
        
        assertDefault(viewModel: circle, fonts: circle.FONT)
        XCTAssertEqual(circle.interval, circle.INTERVAL)
        XCTAssertEqual(circle.depth, circle.DEPTH)
        XCTAssertEqual(circle.gap, circle.GAP)
        XCTAssertEqual(circle.rotationAngle, circle.ROTATION)
        
        // Save the test data and check if it has been saved correctly.
        let random = CircleViewModel()
        random.isRandomStyle = true
        random.makeRandomStyle()
        random.isRandomStyle = false
        circle = CircleViewModel()
        
        assertEqual(viewModel: circle, with: random)
        XCTAssertEqual(circle.interval, random.interval)
        XCTAssertEqual(circle.depth, random.depth)
        XCTAssertEqual(circle.gap, random.gap)
        XCTAssertEqual(circle.rotationAngle, random.rotationAngle)

        // Clear the changes.
        circle.resetUserDefaults()
    }
    
    func test07_Worm() {
        
        // Check if the default style has been saved.
        var worm = WormViewModel()
        worm.resetUserDefaults()
        worm = WormViewModel()
        
        assertDefault(viewModel: worm, fonts: worm.FONT)
        XCTAssertEqual(worm.interval, worm.INTERVAL)
        XCTAssertEqual(worm.length, worm.LENGTH)
        XCTAssertEqual(worm.step, worm.STEP)
        XCTAssertEqual(worm.crawling, worm.CRAWLING)
        XCTAssertEqual(worm.padding, worm.PADDING)
        
        // Save the test data and check if it has been saved correctly.
        let random = WormViewModel()
        random.isRandomStyle = true
        random.makeRandomStyle()
        random.isRandomStyle = false
        worm = WormViewModel()
        
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
        
        // Check if the default style has been saved.
        var bigbang = BigBangViewModel()
        bigbang.resetUserDefaults()
        bigbang = BigBangViewModel()
        
        assertDefault(viewModel: bigbang, fonts: bigbang.FONT)
        XCTAssertEqual(bigbang.scale, bigbang.SCALE)
        XCTAssertEqual(bigbang.interval, bigbang.INTERVAL)
        XCTAssertEqual(bigbang.gap, bigbang.GAP)
        XCTAssertEqual(bigbang.rotationAngle, bigbang.ROTATION)
        XCTAssertEqual(bigbang.padding, bigbang.PADDING)
        XCTAssertEqual(bigbang.is3D, bigbang.IS_3D)
        
        // Save the test data and check if it has been saved correctly.
        let random = BigBangViewModel()
        random.isRandomStyle = true
        random.makeRandomStyle()
        random.isRandomStyle = false
        bigbang = BigBangViewModel()
        
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
        
        // Check if the default style has been saved.
        var rain = RainViewModel()
        rain.resetUserDefaults()
        rain = RainViewModel()
        
        assertDefault(viewModel: rain, fonts: rain.FONT)
        XCTAssertEqual(rain.scale, rain.SCALE)
        XCTAssertEqual(rain.interval, rain.INTERVAL)
        XCTAssertEqual(rain.length, rain.LENGTH)
        XCTAssertEqual(rain.step, rain.STEP)
        
        // Save the test data and check if it has been saved correctly.
        let random = RainViewModel()
        random.isRandomStyle = true
        random.makeRandomStyle()
        random.isRandomStyle = false
        rain = RainViewModel()
        
        assertEqual(viewModel: rain, with: random)
        XCTAssertEqual(rain.scale, random.scale)
        XCTAssertEqual(rain.interval, random.interval)
        XCTAssertEqual(rain.length, random.length)
        XCTAssertEqual(rain.step, random.step)

        // Clear the changes.
        rain.resetUserDefaults()
    }
    
    func test10_Geometry() {
        
        // Check if the default style has been saved.
        var geometry = GeometryViewModel()
        geometry.resetUserDefaults()
        geometry = GeometryViewModel()
        
        assertDefault(viewModel: geometry, fonts: geometry.FONT)
        XCTAssertEqual(geometry.shape, geometry.SHAPE)
        XCTAssertEqual(geometry.scale, geometry.SCALE)
        XCTAssertEqual(geometry.interval, geometry.INTERVAL)
        XCTAssertEqual(geometry.isFill, geometry.IS_FILL)
        
        // Save the test data and check if it has been saved correctly.
        let random = GeometryViewModel()
        random.isRandomStyle = true
        random.makeRandomStyle()
        random.isRandomStyle = false
        geometry = GeometryViewModel()
        
        assertEqual(viewModel: geometry, with: random)
        XCTAssertEqual(geometry.shape, random.shape)
        XCTAssertEqual(geometry.scale, random.scale)
        XCTAssertEqual(geometry.interval, random.interval)
        XCTAssertEqual(geometry.isFill, random.isFill)

        // Clear the changes.
        geometry.resetUserDefaults()
    }
}
