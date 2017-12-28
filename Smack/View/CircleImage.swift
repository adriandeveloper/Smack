//
//  CircleImage.swift
//  Smack
//
//  Created by Adrian Thomas on 12/28/17.
//  Copyright © 2017 Adrian Thomas. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

  override func awakeFromNib() {
    setupView()
  }
  
  func setupView() {
    self.layer.cornerRadius = self.frame.width / 2
    clipsToBounds = true
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setupView()
  }

}
