//
//  BarChartViewController.swift
//  BarChartView
//
//  Created by Shweta Shendage on 18/06/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import UIKit

class BarChartViewController: UIViewController {
  
  @IBOutlet weak var horizontalStackView: UIStackView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  let service = BarChartService()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    view.backgroundColor = UIColor().BCVbackGroundColor()
    
    service.getFacts() { result in
      
      self.activityIndicator.stopAnimating()
      
      if let result = result{
        
        for graphElement in result {
          
          self.addGraphElementsOnHorizontalStackView(graphElement: graphElement)
          
        }
      }
      
    }
  }
  private func addGraphElementsOnHorizontalStackView (graphElement: BarGraphElement) {
    
    let heightOfOneBar = heightOfBarElement(value: graphElement.value)
    
    let verticalStackView: UIStackView = UIStackView()
    verticalStackView.axis = .vertical
    verticalStackView.alignment = .fill
    verticalStackView.distribution = .fill
    
    let singleBarStack = BarRoundedCorner()
    singleBarStack.backgroundColor = UIColor().BCVbarColor()
    singleBarStack.heightAnchor.constraint(equalToConstant: heightOfOneBar).isActive = true
    
    verticalStackView.addArrangedSubview(singleBarStack)
    verticalStackView.heightAnchor.constraint(equalToConstant: heightOfOneBar).isActive = true
    verticalStackView.translatesAutoresizingMaskIntoConstraints = false;
    
    horizontalStackView.addArrangedSubview(verticalStackView)
    horizontalStackView.translatesAutoresizingMaskIntoConstraints = false;
  }
  
  private func heightOfBarElement (value: Int) -> CGFloat {
    
    let maxHeight: CGFloat = UIScreen.main.bounds.size.height * CGFloat(BCVConstants.BCVBarHeightComponentWRTScreen)
    
    return (CGFloat(value*100/BCVConstants.BCVMaximumValueOfElement) * maxHeight) / 100
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
}

