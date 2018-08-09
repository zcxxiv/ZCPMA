//
//  LocationSelectionInputsViewController.swift
//  ZCPMA
//
//  Created by ZIYUAN CHEN on 8/6/18.
//  Copyright © 2018 Sheprd. All rights reserved.
//

import UIKit

class LocationSelectionInputsViewController: UIViewController {
  
  @IBOutlet weak var pickupLocationTextField: UITextField!
  @IBOutlet weak var dropOffLocationTextField: UITextField!
  
  @IBAction func updatePickupLocationSearchResult(_ sender: UITextField!) {
    RideCreator.shared.locationSearchInput = (.Pickup, sender.text)
  }
  
  @IBAction func focusOnPickupLocation(_ sender: Any) {
    RideCreator.shared.locationTypeToEdit = .Pickup
  }
  
  @IBAction func updateDropOffLocationSearchResult(_ sender: UITextField!) {
    RideCreator.shared.locationSearchInput = (.DropOff, sender.text)
  }
  
  @IBAction func focusOnDropOffLocation(_ sender: Any) {
    RideCreator.shared.locationTypeToEdit = .DropOff
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    pickupLocationTextField.resignFirstResponder()
    dropOffLocationTextField.resignFirstResponder()
    self.view.endEditing(true)
  }
  
  func updateUI() {
    let rc = RideCreator.shared
    if let pickupLocation = rc.pickupLocation {
      if rc.dropOffLocation != nil {
        (self.parent as? LocationSelectionViewController)?.done(self)
      } else {
        pickupLocationTextField.text = pickupLocation.title
        rc.locationTypeToEdit = .DropOff
        dropOffLocationTextField.becomeFirstResponder()
      }
    } else {
      if let dropOffLocation = rc.dropOffLocation {
        dropOffLocationTextField.text = dropOffLocation.title
        rc.locationTypeToEdit = .Pickup
        pickupLocationTextField.becomeFirstResponder()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pickupLocationTextField.delegate = self
    dropOffLocationTextField.delegate = self
    
    let rc = RideCreator.shared
    
    if rc.locationTypeToEdit == .Pickup {
      dropOffLocationTextField.text = rc.dropOffLocation?.title ?? ""
      pickupLocationTextField.placeholder = rc.pickupLocation?.title ?? ""
      pickupLocationTextField.becomeFirstResponder()
    } else {
      pickupLocationTextField.text = rc.pickupLocation?.title ?? ""
      dropOffLocationTextField.placeholder = rc.dropOffLocation?.title ?? ""
      dropOffLocationTextField.becomeFirstResponder()
    }

    NotificationCenter.default.addObserver(
      forName: .SheprdPickupLocationChange,
      object: nil,
      queue: OperationQueue.main) { [weak self] _ in self?.updateUI() }
    
    NotificationCenter.default.addObserver(
      forName: .SheprdDropOffLocationChange,
      object: nil,
      queue: OperationQueue.main) { [weak self] _ in self?.updateUI() }
  }
  
}

extension LocationSelectionInputsViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    if textField == pickupLocationTextField {
      RideCreator.shared.pickupLocation = nil
    } else if textField == dropOffLocationTextField {
      RideCreator.shared.dropOffLocation = nil
    }
    return true
  }
}

