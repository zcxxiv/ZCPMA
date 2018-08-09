//
//  LocationTabelViewCell.swift
//  ZCPMA
//
//  Created by ZIYUAN CHEN on 8/4/18.
//  Copyright © 2018 Sheprd. All rights reserved.
//

import UIKit

class LocationTabelViewCell: UITableViewCell {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var primaryAddressLabel: UILabel!
  @IBOutlet weak var secondaryAddressLabel: UILabel!
  @IBOutlet weak var locationAnnotationLabel: UILabel!
  
  var isSheprdLocation: Bool = false
  var isRecentLocation: Bool = false
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if isRecentLocation {
      iconImageView.image = UIImage(named: .RecentLocationIcon)
      locationAnnotationLabel.text = .RecentLocationAnnotationText
    } else if isSheprdLocation {
      iconImageView.image = UIImage(named: .SheprdLocationIcon)
      locationAnnotationLabel.text = .SheprdLocationAnnotationText
    } else {
      iconImageView.image = UIImage(named: .LocationIcon)
      locationAnnotationLabel.text = .LocationAnnotationText
    }
  }
  
  func configure(location: RideCreator.Location) {
    primaryAddressLabel.text = location.title
    secondaryAddressLabel.text = location.secondaryDescription
    isSheprdLocation = location.isSheprdLocation
    isRecentLocation = location.isRecentLocation
  }
  
}

fileprivate extension String {
  static let SheprdLocationAnnotationText = "verified"
  static let RecentLocationAnnotationText = "recent"
  static let LocationAnnotationText = ""
  static let SheprdLocationIcon = "sheprd-location-pin"
  static let RecentLocationIcon = "recent-location"
  static let LocationIcon = "location-pin"
}
