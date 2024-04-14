//
//  Jinal_Chandibhamar_FE_8961760UITestsLaunchTests.swift
//  Jinal_Chandibhamar_FE_8961760UITests
//
//  Created by user239775 on 4/9/24.
//

import XCTest

final class Jinal_Chandibhamar_FE_8961760UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
