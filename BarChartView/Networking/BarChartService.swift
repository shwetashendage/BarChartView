//
//  BarChartService.swift
//  BarChartView
//
//  Created by Shweta Shendage on 16/06/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import Foundation

class BarChartService {
  
  typealias JSONDictionary = [String: Any]
  typealias chartResult = ([BarGraphElement]?) -> ()
  
  var defaultSession = URLSession(configuration: .default)
  var dataTask: URLSessionDataTask?
  var chartDataArray: [BarGraphElement] = []
  let defaultData: [JSONDictionary] = [["index":1,"value":4],["index":2,"value":2],["index":3,"value":1],["index":4,"value":3],["index":5,"value":5],["index":6,"value":3],["index":7,"value":2],["index":8,"value":1],["index":9,"value":5],["index":10,"value":3]]

  func getFacts(completion: @escaping chartResult) {
    
    //    Webservice call
    dataTask?.cancel()
    
    guard let url = URL(string: BCVConstants.BCVChartDataUrl) else {
      return
    }
    
    dataTask = defaultSession.dataTask(with: url) { data, response, error in
      defer {
        self.dataTask = nil
        
      }
      
      if let error = error {
        //Default Data
        self.createDefaultDataModel()
        print(error)
      } else if let data = data,
        let response = response as? HTTPURLResponse,
        response.statusCode == 200 {
        //        Parse Data
        self.createChartDataArray(data)
      }
      DispatchQueue.main.async {
        completion(self.chartDataArray)
      }
    }
    
    dataTask?.resume()
    
  }
  
  func createChartDataArray(_ data: Data) {
    //     Parse data
    var response: JSONDictionary?
    //Remove all objects always
    chartDataArray.removeAll()
    do {
      response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
    } catch _ as NSError {
      //Default Data
      createDefaultDataModel()
      return
    }
    guard let array = response![BCVConstants.BCVKeys.graph] as? [JSONDictionary] else {
      //Default Data
      createDefaultDataModel()
      return
    }
    
    chartDataArray = array.compactMap({ dataDictionary in
      BarGraphElement(index: dataDictionary[BCVConstants.BCVKeys.index] as! Int, value: dataDictionary[BCVConstants.BCVKeys.value] as! Int)
    })
    
  }
  
  func createDefaultDataModel() {
    chartDataArray = defaultData.compactMap({ dataDictionary in
      BarGraphElement(index: dataDictionary[BCVConstants.BCVKeys.index] as! Int, value: dataDictionary[BCVConstants.BCVKeys.value] as! Int)
    })
  }
  
}
