//
//  BarChartViewController.swift
//  BarChartView
//
//  Created by Shweta Shendage on 18/06/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import UIKit

class BarChartViewController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  let service = BarChartService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    service.getFacts() { result in
      
      self.activityIndicator.stopAnimating()
      
      if let result = result{
        print(result)
      }
      
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
}

