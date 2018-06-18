//
//  BarChartViewModelTests.swift
//  BarChartViewModelTests
//
//  Created by Shweta Shendage on 18/06/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import XCTest

class BarChartViewModelTests: XCTestCase {
  
  var systemUnderTest : BarChartService!
  
  override func setUp() {
    super.setUp()
    systemUnderTest = BarChartService()
    systemUnderTest.defaultSession = URLSession(configuration: .default)
  }
  
  override func tearDown() {
    systemUnderTest = nil
    super.tearDown()
  }
  
  func testCheckIfDataParsedCorrectly(){
    
    let makeExpectation = expectation(description: "Status code: 200")
    
    let url = URL(string: BCVConstants.BCVChartDataUrl)
    let dataTask = systemUnderTest?.defaultSession.dataTask(with: url!) {
      data, response, error in
      if let error = error {
        print(error.localizedDescription)
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          self.systemUnderTest?.createChartDataArray(data!)
          makeExpectation.fulfill()
          
        }
      }
    }
    dataTask?.resume()
    waitForExpectations(timeout: 60, handler: nil)
    
    XCTAssertGreaterThan(systemUnderTest!.chartDataArray.count, 0, "No Elements")
  }
  
}
