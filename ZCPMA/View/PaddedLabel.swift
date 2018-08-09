//
//  PaddedLabel.swift
//  ZCPMA
//
//  Created by ZIYUAN CHEN on 8/9/18.
//  Copyright © 2018 Sheprd. All rights reserved.
//

import UIKit

@IBDesignable class PaddedLabel: UILabel {
  
  @IBInspectable var topInset: CGFloat = 0.0
  @IBInspectable var bottomInset: CGFloat = 0
  @IBInspectable var leftInset: CGFloat = 16.0
  @IBInspectable var rightInset: CGFloat = 0
  
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
  }
  
  override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + leftInset + rightInset,
                  height: size.height + topInset + bottomInset)
  }
}
