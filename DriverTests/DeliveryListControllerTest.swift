//
//  PendingDeliveriesListTest.swift
//  
//
//  Created by Zeeshan on 5/12/19.
//

import XCTest
@testable import Driver

class DeliveryListControllerTest: XCTestCase {
    
    var controller: DeliveryListController!
    
    override func setUp() {
        controller = DeliveryListController(nibName: "DeliveryListController", bundle: .main)
        _ = controller.view
    }
    
    override func tearDown() {
        controller = nil
    }
    
    func testOutletBinding() {
        XCTAssertNotNil(controller?.tableView, "Connect tableView outlet")
        
        if let tableView = controller?.tableView {
            
            XCTAssertNotNil(tableView.delegate as? DeliveryListController, "TableView delegate not assigned")
            XCTAssertNotNil(tableView.dataSource as? DeliveryListController, "TableView dataSource not assigned")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryCell")
            XCTAssertNotNil(cell, "TableView cell not registered with reusable identifier Cell")
            let c = cell as? DeliveryCell
            XCTAssertNotNil(c, "Cell class is not appropriate")
            XCTAssertNotNil(c?.deliveryTypeLabel, "Connect deliveryTypeLabe outlet")
            XCTAssertNotNil(c?.bottomStackView, "Connect bottomStackView outlet")
            XCTAssertNotNil(c?.userImage, "Connect userImage outlet")
            XCTAssertNotNil(c?.nameLabel, "Connect nameLabel outlet")
            XCTAssertNotNil(c?.addressLabel, "Connect addressLabel outlet")
            XCTAssertNotNil(c?.timeLabel, "Connect timeLabel outlet")
        }
    }
    
    func testTableNoOfRows() {
        XCTAssertEqual(controller.tableView.numberOfRows(inSection: 0), 0, "In the beggining, tableview should have no records")
    }
}
