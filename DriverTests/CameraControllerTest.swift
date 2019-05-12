//
//  CameraControllerTest.swift
//  DriverTests
//
//  Created by Zeeshan on 5/12/19.
//  Copyright © 2019 ingic. All rights reserved.
//

import XCTest
@testable import Driver

class CameraControllerTest: XCTestCase {
    
    var controller: CameraViewController!
    
    override func setUp() {
        controller = CameraViewController(nibName: "CameraViewController", bundle: .main)
        _ = controller.view
    }
    
    override func tearDown() {
        controller = nil
    }
    
    func testOutletBinding() {
        
//        if let imagePicker = controller?.imagePicker {
//
//            XCTAssertNotNil(imagePicker.delegate as? CameraViewController, "imagePicker delegate not assigned")
//        }
        
            XCTAssertNotNil(controller?.captureButton, "Connect captureButton outlet")
            XCTAssertNotNil(controller?.galleryButton, "Connect galleryButton outlet")
    }
    
}
