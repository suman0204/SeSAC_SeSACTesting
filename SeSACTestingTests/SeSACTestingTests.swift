//
//  SeSACTestingTests.swift
//  SeSACTestingTests
//
//  Created by 홍수만 on 2023/12/08.
//

import XCTest
@testable import SeSACTesting

// LoginVC 안에 있는 valid 메서드를 테스트
final class SeSACTestingTests: XCTestCase {

    var sut: LoginViewController! //시스템이 테스트를 하려는 대상 (System Under Test)
    
    // 테스트 시작 전 값 세팅
    override func setUpWithError() throws {
        print(#function)
        
        let sb = UIStoryboard(name: "Login", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        sut = vc
        sut.loadViewIfNeeded()
    }

    // 테스트 이후 세팅된 값 초기화 (nil로 설정)
    override func tearDownWithError() throws {
        print(#function)
        
        sut = nil
    }

    //테스트
    func testLoginViewController_ValidEmail_ReturnTrue() throws {
        print(#function)
        
        sut.emailTextField.text = "jack@test.com"
        
        XCTAssertTrue(sut.isValidEmail(), "@ 없거나 6글자 미만입니다")
    }
    
    //테스트 결과가 성공이지만, 사실 실패 케이스를 테스트 한 것
    //'@'가 없어서 실패하는 케이스를 테스트하는것 -> false인 경우 테스트 성공
    func testLoginViewController_ValidEmail_ReturnFalse() throws { //실패 케이스를 테스트 하고 싶은 것.
        print(#function)
        
        sut.emailTextField.text = "jacktest.com"
        
        XCTAssertFalse(sut.isValidEmail(), "@ 없거나 6글자 미만입니다")
    }
    
    func testLoginViewController_Testing_ReturnNil() throws {
        sut.emailTextField = nil
        
        XCTAssertNil(sut.emailTextField, "Nil")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
