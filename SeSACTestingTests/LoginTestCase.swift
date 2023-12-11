//
//  LoginTestCase.swift
//  SeSACTestingTests
//
//  Created by 홍수만 on 2023/12/11.
//

import XCTest
@testable import SeSACTesting

final class LoginTestCase: XCTestCase {
    
    var sut: Validator!

    let user = User(email: "jack@test.com", password: "123456", check: "123456")
    
    override func setUpWithError() throws {
       sut = Validator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testValidator_ValidEmail_ReturnTrue() throws {
        
        let valid = sut.isValidEmail(email: user.email)
        
        XCTAssertTrue(valid, "@없거나 6글자 미만입니다.")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
