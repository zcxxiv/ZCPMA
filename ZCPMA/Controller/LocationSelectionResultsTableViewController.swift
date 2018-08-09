//
//  LocationSelectionResultsTableViewController.swift
//  ZCPMA
//
//  Created by ZIYUAN CHEN on 8/6/18.
//  Copyright © 2018 Sheprd. All rights reserved.
//

import UIKit

class LocationSelectionResultsTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()

    NotificationCenter.default.addObserver(
      forName: .ShperdSelectableLocationsChange,
      object: nil,
      queue: OperationQueue.main) { [weak self] _ in self?.tableView.reloadData() }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return RideCreator.shared.selectableLocations.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "LocationTableViewCell"
      ) as! LocationTabelViewCell
    let location = RideCreator.shared.selectableLocations[indexPath.row]
    cell.configure(location: location)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let rc = RideCreator.shared
    let locationSelected = rc.selectableLocations[indexPath.row]
    switch rc.locationTypeToEdit {
    case .Pickup:
      rc.pickupLocation = locationSelected
    case .DropOff:
      rc.dropOffLocation = locationSelected
    }
  }

}
