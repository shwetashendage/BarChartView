//
//  BarRoundedCorner.swift
//  BarChartView
//
//  Created by Shweta Shendage on 16/06/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import Foundation
import UIKit

class BarRoundedCorner: UIView {
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.roundCorners([.topLeft, .topRight], radius: self.bounds.size.width/CGFloat(BCVConstants.BCVBarCornerRadiusComponent))
  }
  
}

extension UIView {
  
  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
  
}
