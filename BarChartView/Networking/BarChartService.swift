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
  typealias chartResult = ([Any]?) -> ()
  
  var defaultSession = URLSession(configuration: .default)
  var dataTask: URLSessionDataTask?
  var chartDataArray: [Any] = []
  
  func getFacts(completion: @escaping chartResult) {
    
    //    Webservice call
    dataTask?.cancel()
    
    guard let url = URL(string: "https://api.myjson.com/bins/ipz6h") else {
      return
    }
    
    dataTask = defaultSession.dataTask(with: url) { data, response, error in
      defer {
        self.dataTask = nil
        
      }
      
      if let error = error {
        //Default Data
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
     
      return
    }
    guard let array = response!["graph"] as? [JSONDictionary] else {
      //Default Data
      return
    }
    print(array)
    
  }
  
}