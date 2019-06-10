//
//  PCL_AdminTests.swift
//  PCL AdminTests
//
//  Created by Manoj on 6/2/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import XCTest
@testable import PCL_Admin

class PCL_AdminTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTimeCompare() {
        let t1 = "10 : 00 AM"
        let t2 = "12 : 10 PM"
        let formatter = DateFormatter()
        formatter.dateFormat = "hh : mm a"
        let dt1 = formatter.date(from: t1)
        let dt2 = formatter.date(from: t2)
        XCTAssertTrue(dt1!.time < dt2!.time)
    }
    
    func testGetLocationCoordinates() {
        let lat = 41.305848, lon = -83.422879
        LocationHelper.getlatlong(address: "487 devon park drive, wayne", completion: {(xlat,xlon) in
            XCTAssertEqual(lat, xlat)
            XCTAssertEqual(lon, xlon)
        })
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
