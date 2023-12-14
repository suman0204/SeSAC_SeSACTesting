//
//  NetworkMockTestCase.swift
//  SeSACTestingTests
//
//  Created by 홍수만 on 2023/12/13.
//

import XCTest
@testable import SeSACTesting

final class NetworkMockTestCase: XCTestCase {

    var sut: NetworkProvider!
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        
        sut.fetchLotto { lotto in
            <#code#>
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
