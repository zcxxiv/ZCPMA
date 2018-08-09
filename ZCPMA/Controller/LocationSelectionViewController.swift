//
//  LocationSelectionViewController.swift
//  ZCPMA
//
//  Created by ZIYUAN CHEN on 8/2/18.
//  Copyright © 2018 Sheprd. All rights reserved.
//

import UIKit

class LocationSelectionViewController: UIViewController {
  @IBAction func done(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
}

extension LocationSelectionViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    self.pickupLocationTextField.text = googlePlacesSearchResults[indexPath.row].primaryAddress
  }
}
