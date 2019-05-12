//
//  MapViewControllerTest.swift
//  DriverTests
//
//  Created by Zeeshan on 5/12/19.
//  Copyright © 2019 ingic. All rights reserved.
//

import XCTest
@testable import Driver

class MapViewControllerTest: XCTestCase {

        var controller: MapViewController!
        
        override func setUp() {
            controller = MapViewController(nibName: "MapViewController", bundle: .main)
            _ = controller.view
        }
        
        override func tearDown() {
            controller = nil
        }
        
    func testOutletBinding() {
        XCTAssertNotNil(controller?.mapView, "Connect mapView outlet")
        XCTAssertNotNil(controller?.navigatorButton, "Connect navigatorButton outlet")
        XCTAssertNotNil(controller?.bottomSheetView, "Connect bottomSheetView outlet")
        XCTAssertNotNil(controller?.bottomSheetTopConstraint, "Connect bottomSheetTopConstraint outlet")
        XCTAssertNotNil(controller?.deliveryTypeLabel, "Connect deliveryTypeLabe outlet")
        XCTAssertNotNil(controller?.userImage, "Connect userImage outlet")
        XCTAssertNotNil(controller?.nameLabel, "Connect nameLabel outlet")
        XCTAssertNotNil(controller?.addressLabel, "Connect addressLabel outlet")
        XCTAssertNotNil(controller?.timeLabel, "Connect timeLabel outlet")
        XCTAssertNotNil(controller?.verifyButtonView, "Connect verifyButtonView outlet")
    }
    
}
