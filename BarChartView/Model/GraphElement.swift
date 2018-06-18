//
//  GraphElement.swift
//  BarChartView
//
//  Created by Shweta Shendage on 16/06/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import Foundation

class GraphElement {
  
  let index: Int
  let value: Int
  
  init?(index: Int, value: Int) {
    
    //Fail initializer if value is greater than assumption
    if value > BCVConstants.BCVMaximumValueOfElement {
      return nil
    }
    self.index = index
    self.value = value
    
  }
  
}
