//
//  UtilsTests.swift
//  OviaTakeHomeTests
//
//  Created by Jian Ma on 3/6/22.
//

import XCTest
@testable import OviaTakeHome

class UtilsTests: XCTestCase {
    
    private func SUT() -> ViewController {
        return ViewController()
    }
    func test_starConversion_fivePointThree_notConvertsTo_fourStars(){
        
        let rating = "5.3"
        
        let input = rating.getStars()
        let output = "⭐⭐⭐⭐"
        
        XCTAssertNotEqual(input, output)
    }
    
    func test_starConversion_eightPointFive_convertsTo_fourStars(){
        
        let rating = "8.5"
        
        let input = rating.getStars()
        let output = "⭐⭐⭐⭐"
        
        XCTAssertEqual(input, output)
    }
    
    func test_emptySearchQuary_initAlertController() {
        let sut = SUT()
        
        sut.textField.text = ""
        sut.searchButton.sendActions(for: .touchUpInside)
        
        XCTAssertNotNil(UIAlertController.custom)
    }
}
