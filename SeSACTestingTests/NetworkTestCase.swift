//
//  NetworkTestCase.swift
//  SeSACTestingTests
//
//  Created by 홍수만 on 2023/12/13.
//

import XCTest
@testable import SeSACTesting

final class NetworkTestCase: XCTestCase {

//    override class func setUp() {
//        print(#function)
//    }
//    
//    override class func tearDown() {
//        print(#function)
//    }
  
    var sut: NetworkManager! // 테스트할 때마다 초기화 해주고 독립적으로 테스트하기 위해서 인스턴스를 생성하지 않는다
    
    override func setUpWithError() throws {
        sut = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    //UnitTest는 동기 테스트에 최적화 되어 있음.
    //비동기 테스트: expectation / fulfill / wait
    func testExample() throws {
        print("1")
        
        let promise = expectation(description: "Lotto Number Competion Handler")
        
        sut.fetchLotto { lotto in
            print("2")
            print(lotto.bnusNo, lotto.drwNoDate, lotto.drwtNo1)
            
            var testNumber = lotto.bnusNo
            
            XCTAssertLessThanOrEqual(testNumber, 45)
            XCTAssertGreaterThanOrEqual(testNumber, 1)
            
            promise.fulfill() // 정의해둔 expectation이 충족되는 시점에 호출해서 동작을 수행했음을 알려줌.
        }
        wait(for: [promise], timeout: 5) //비동기 작업을 기다림. 타임아웃 시간이 지나면 실패로 간주!
        
        print("3")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
