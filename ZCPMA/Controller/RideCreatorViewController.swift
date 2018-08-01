//
//  SelectRiderViewController.swift
//  ZCPMA
//
//  Created by ZIYUAN CHEN on 7/28/18.
//  Copyright © 2018 Sheprd. All rights reserved.
//

import UIKit
import Eureka
import PKHUD

class RideCreatorViewController: FormViewController {
  
  private func populateRidersList() {
    let riders = RideCreator.shared.riders.map { "\($0.firstName ?? "") \($0.lastName ?? "")" }
    for rider in riders {
      form[0] <<< ListCheckRow<String>(rider) { listRow in
        listRow.title = rider
        listRow.selectableValue = rider
        listRow.value = rider
      }.cellSetup({ (cell, row) in
        cell.tintColor = ThemeManager.primaryColor()
      })
    }
  }
  
  private var pickUpLocationRow: ButtonRow {
    return ButtonRow("Burr Elementary School") {
      $0.title = $0.tag
      $0.presentationMode = .segueName(
        segueName: "RideCreatorToRideConfirmationSegue",
        onDismiss: nil
      )
    }
  }
  
  private var dropOffLocationRow: ButtonRow {
    return ButtonRow("West Suburban YMCA") {
      $0.title = $0.tag
      $0.presentationMode = .segueName(
        segueName: "RideCreatorToRideConfirmationSegue",
        onDismiss: nil
      )
    }
  }
  
  private var recurringRow: SwitchRow {
    return SwitchRow("Recurring") {
      $0.title = $0.tag
      $0.value = RideCreator.shared.recurring
    }.cellSetup { cell, row in
      cell.switchControl.onTintColor = ThemeManager.primaryColor()
    }.onChange { row in
      RideCreator.shared.recurring = row.value ?? false
    }
  }
  
  private var rideDateRow: DateInlineRow {
    return DateInlineRow("RideDate") {
      $0.title = "Ride Date"
      $0.value = RideCreator.shared.startDate
      $0.hidden = "$Recurring == true"
    }.onChange { row in
      guard let rideDate = row.value else { return }
      RideCreator.shared.startDate = rideDate
      RideCreator.shared.endDate = rideDate
    }.cellUpdate {cell, row in
      row.baseValue = RideCreator.shared.startDate
      cell.update()
      row.reload()
    }
  }
  
  private var startDateRow: DateInlineRow {
    return DateInlineRow("StartDate") {
      $0.title = "Start Date"
      $0.value = RideCreator.shared.startDate
      $0.hidden = "$Recurring == false"
    }.onChange { row in
      guard let startDate = row.value else { return }
      RideCreator.shared.startDate = startDate
    }.cellUpdate {cell, row in
      row.baseValue = RideCreator.shared.startDate
      cell.update()
      row.reload()
    }
  }
  
  private var endDateRow: DateInlineRow {
    return DateInlineRow("EndDate") {
      $0.title = "End Date"
      $0.value = RideCreator.shared.endDate
      $0.hidden = "$Recurring == false"
    }.onChange { row in
      guard let endDate = row.value else { return }
      RideCreator.shared.endDate = endDate
    }
  }
  
  private var excludingDatesRow: ButtonRow {
    return ButtonRow("Excluding Dates") {
      $0.title = $0.tag
      $0.hidden = "$Recurring == false"
      $0.presentationMode = .segueName(segueName: "ShowExcludingDaysModalSegue", onDismiss: nil)
    }
  }
  
  private var repeatDaysLabelRow: LabelRow {
    return LabelRow() {
      $0.title = "Repeat On"
      $0.hidden = "$Recurring == false"
    }
  }
  
  private var repeatDaysRow: WeekDayRow {
    return WeekDayRow() {
      $0.title = "Repeat Days"
      $0.value = [.monday, .wednesday, .friday]
      $0.hidden = "$Recurring == false"
    }
  }
  
  private var favoredRow: SegmentedRow<String> {
    return SegmentedRow<String>("Favored") {
      $0.title = "Favor" + "              " // some hacky padding
      $0.value = RideCreator.shared.favored.rawValue
      $0.options = ["Departure", "Arrival"]
      }.cellSetup { cell, row in
        cell.tintColor = ThemeManager.primaryColor()
      }.onChange {row in
        let section = row.section
        RideCreator.shared.favored.toggle()
        section?.footer = HeaderFooterView(title: RideCreator.shared.favored.explanation)
        section?.reload()
      }
  }
  
  private var rideTimeRow: TimeInlineRow {
    return TimeInlineRow("RideTime")
      .cellUpdate { cell, row in
        row.title = RideCreator.shared.favored.rideTimeLabel
        cell.update()
      }
  }
  
  private var nextRow: ButtonRow {
    return ButtonRow() { $0.title = "Next" }
      .onCellSelection { [weak self] (cell, row) in
        self?.performSegue(withIdentifier: "RideCreatorToRideConfirmationSegue", sender: nil)
      }
      .cellSetup({ (cell, _) in
        cell.tintColor = ThemeManager.primaryColor()
      })
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    HUD.show(.systemActivity)
    DatabaseManager.getMember(memberId: "cjjk4n15rbfx10136purn9ktc") {[weak self] member, error in
      guard error == nil, let member = member else { return }
      RideCreator.shared.resetForMember(member: member)
      self?.populateRidersList()
      HUD.hide()
    }
    
    NotificationCenter.default.addObserver(
      forName: .SheprdStartDateChange,
      object: nil,
      queue: nil) { [weak self] notification in
        guard let startDate = notification.userInfo?["StartDate"] as? Date else { return }
        self?.form.rowBy(tag: "RideDate")?.reload()
        self?.form.rowBy(tag: "StartDate")?.reload()
        self?.form.rowBy(tag: "EndDate")?.reload()
    }
    
    form
      +++ SelectableSection<ListCheckRow<String>>("Riders", selectionType: .multipleSelection)
      +++ Section("Ride Locations")
        <<< pickUpLocationRow
        <<< dropOffLocationRow
      +++ Section("Ride Dates")
        <<< recurringRow
        <<< rideDateRow
        <<< startDateRow
        <<< endDateRow
        <<< excludingDatesRow
        <<< repeatDaysLabelRow
        <<< repeatDaysRow
      +++ Section(header: "Ride Times", footer: RideCreator.shared.favored.explanation)
        <<< favoredRow
        <<< rideTimeRow
      +++ Section()
        <<< nextRow
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "RideCreatorToRideConfirmationSegue" {
      print("to ride creator")
    }
  }
  
}
