//
//  NumberTestCase.swift
//  MapAppTests
//
//  Created by Ngo Van Hai on 9/25/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import XCTest
@testable import MapApp
import RxSwift


class NumberTestCase: XCTestCase {
    var numberViewModel: NumberViewModel!
    var numberVC: NumberViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        numberViewModel = NumberViewModel()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let numberViewControler = storyboard.instantiateViewController(withIdentifier: "NumberViewController") as! NumberViewController
        numberVC = numberViewControler
        _ = numberVC.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        numberViewModel = nil
        numberVC = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testNumberUp() {
        let oldValue = Int(numberVC.numberView.text!)
        numberVC.upButton.sendActions(for: .touchUpInside)
        let newValue = Int(numberVC.numberView.text!)
        
        XCTAssertEqual(oldValue! + 2, newValue)
        
    }
    
    func testNumberDown() {
        let oldValue = Int(numberVC.numberView.text!)
        numberVC.downButton.sendActions(for: .touchUpInside)
        let newValue = Int(numberVC.numberView.text!)
        
        XCTAssertEqual(oldValue! - 1, newValue)
    }
    
    func testDownActionWithZeroValue() {
        numberVC.numberViewModel.clear()
        let oldValue = Int(numberVC.numberView.text!)
        numberVC.downButton.sendActions(for: .touchUpInside)
        let newValue = Int(numberVC.numberView.text!)
        
        XCTAssertEqual(oldValue!, 0)
        XCTAssertEqual(newValue!, 0)
        XCTAssertEqual(numberVC.downButton.isEnabled, false)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
