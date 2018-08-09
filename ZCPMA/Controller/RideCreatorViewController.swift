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
  
    // MARK: - Rows
  
  private var pickUpLocationRow: ButtonRow {
    return ButtonRow("PickupLocation") { row in
      row.title = RideCreator.shared.pickupLocationLabel
      row.presentationMode = .segueName(
        segueName: "RideCreatorToLocationSelectionSegue",
        onDismiss: nil
      )
      row.add(rule: RuleClosure(closure: RideCreator.shared.pickupLocationValidator))
      row.validationOptions = .validatesOnDemand
    }.cellUpdate {cell, row in
      cell.textLabel?.textColor = RideCreator.shared.pickupLocationLabelColor
      row.title = RideCreator.shared.pickupLocationLabel
    }.onRowValidationChanged(handleValidationChange)
  }
  
  private var dropOffLocationRow: ButtonRow {
    return ButtonRow("DropOffLocation") { row in
      row.title = RideCreator.shared.dropOffLocationLabel
      row.presentationMode = .segueName(
        segueName: "RideCreatorToLocationSelectionSegue",
        onDismiss: nil
      )
      row.add(rule: RuleClosure(closure: RideCreator.shared.dropOffLocationValidator))
      row.validationOptions = .validatesOnDemand
    }.cellUpdate {cell, row in
      cell.textLabel?.textColor = RideCreator.shared.dropOffLocationLabelColor
      row.title = RideCreator.shared.dropOffLocationLabel
    }.onRowValidationChanged(handleValidationChange)
  }
  
  private var recurringRow: SwitchRow {
    return SwitchRow("Recurring") {
      $0.title = $0.tag
      $0.value = RideCreator.shared.recurring
      $0.add(rule: RuleClosure(closure: RideCreator.shared.rideDatesValidator))
      $0.validationOptions = .validatesOnDemand
    }.cellSetup { cell, row in
      cell.switchControl.onTintColor = ThemeManager.primaryColor()
    }.onChange { row in
      RideCreator.shared.recurring = row.value ?? false
    }.onRowValidationChanged(handleValidationChange)
  }
  
  private func configureDateCell<T>(cell: DateCell, _: Row<T>) {
    cell.tintColor = ThemeManager.primaryColor()
    cell.datePicker.setValue(ThemeManager.primaryColor(), forKey: "tintColor")
    cell.datePicker.setValue(UIColor(white: 1.0, alpha: 1.0), forKey: "backgroundColor")
  }
  
  private var rideDateRow: DateRow {
    return DateRow("RideDate") {
      $0.title = "Ride Date"
      $0.value = RideCreator.shared.startDate
      $0.minimumDate = Date().startOfDay()
      $0.hidden = "$Recurring == true"
    }.cellSetup(configureDateCell).onChange { row in
      guard let rideDate = row.value else { return }
      RideCreator.shared.startDate = rideDate.startOfDay()
      RideCreator.shared.endDate = rideDate.startOfDay()
    }.cellUpdate {cell, row in
      row.baseValue = RideCreator.shared.startDate
      cell.update()
    }
  }
  
  private var startDateRow: DateRow {
    return DateRow("StartDate") {
      $0.title = "Start Date"
      $0.value = RideCreator.shared.startDate
      $0.minimumDate = Date().startOfDay()
      $0.hidden = "$Recurring == false"
    }.cellSetup(configureDateCell).onChange { row in
      guard let startDate = row.value else { return }
      RideCreator.shared.startDate = startDate.startOfDay()
    }.cellUpdate {cell, row in
      row.baseValue = RideCreator.shared.startDate
      cell.update()
    }
  }
  
  private var endDateRow: DateRow {
    return DateRow("EndDate") {
      $0.title = "End Date"
      $0.value = RideCreator.shared.endDate
      $0.minimumDate = RideCreator.shared.startDate
      $0.hidden = "$Recurring == false"
    }.cellSetup(configureDateCell).onChange { row in
      guard let endDate = row.value else { return }
      RideCreator.shared.endDate = endDate.startOfDay()
    }.cellUpdate { cell, row in
      row.baseValue = RideCreator.shared.endDate
      cell.update()
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
      $0.value = RideCreator.shared.repeatDays
      $0.hidden = "$Recurring == false"
    }.onChange { row in
      guard let repeatdays = row.value else { return }
      RideCreator.shared.repeatDays = repeatdays
    }
  }
  
  private var favoredRow: SegmentedRow<String> {
    return SegmentedRow<String>("Favored") {
      $0.title = "Favor" + "              " // some hacky padding
      $0.value = RideCreator.shared.favored.rawValue
      $0.options = ["Departure", "Arrival"]
      }.cellSetup { cell, row in
        cell.tintColor = ThemeManager.primaryColor()
      }.onChange {[weak self] row in
        RideCreator.shared.favored.toggle()
        guard let section = row.section else { return }
        if section.footer?.title != String.noRideTimeErrorMessage {
          section.footer =
            HeaderFooterView(title: RideCreator.shared.favored.explanation)
          self?.reloadSection(section: section)
        }
      }
  }
  
  private var rideTimeRow: TimeRow {
    return TimeRow("RideTime") {
        $0.add(rule: RuleRequired(msg: .noRideTimeErrorMessage, id: nil))
        $0.validationOptions = .validatesOnChange
      }.onChange {
        RideCreator.shared.rideTime = $0.value
      }.cellSetup(configureDateCell)
      .cellUpdate { cell, row in
        row.title = RideCreator.shared.favored.rideTimeLabel
        cell.update()
      }.onRowValidationChanged(handleValidationChange)
  }
  
  private var nextRow: ButtonRow {
    return ButtonRow() {
        $0.title = "Next"
      }.onCellSelection { [weak self] (cell, row) in
        let errors = self?.form.validate()
        if errors == nil || errors!.isEmpty {
          self?.performSegue(withIdentifier: "RideCreatorToRideConfirmationSegue", sender: nil)
        }
      }.cellSetup({ (cell, _) in
        cell.tintColor = ThemeManager.primaryColor()
      })
  }
  
  // MARK: - Helpers
  
  private func populateRidersList() {
    let rc = RideCreator.shared
    for rider in rc.riders {
      form[0]
        <<< ListCheckRow<String> { row in
          row.title = "\(rider.firstName ?? "") \(rider.lastName ?? "")"
          row.selectableValue = rider.id
          row.value = rider.id
          row.add(rule: RuleClosure(closure: RideCreator.shared.riderValidator))
          row.validationOptions = .validatesOnDemand
          }.cellSetup { (cell, row) in
            cell.tintColor = ThemeManager.primaryColor()
          }.onChange {row in
            if let section = row.section as? SelectableSection<ListCheckRow<String>> {
              rc.riders = section.selectedRows().map { rider in
                rc.allRiders.first { $0.id == rider.value! }!
              }
            }
          }.onRowValidationChanged(handleValidationChange)
    }
  }
  
  private func handleValidationChange<T, U>(cell: Cell<T>, row: Row<U>) {
    guard let section = row.section else { return }
    let sectionError = (section.first { !$0.validationErrors.isEmpty })?.validationErrors.first
    let currentFooterTitle = section.footer?.title
    guard sectionError?.msg != currentFooterTitle else { return }
    var footer = HeaderFooterView<PaddedLabel>(.class)
    footer.title = sectionError?.msg
    footer.onSetupView = { view, _ in
      view.font = UIFont.preferredFont(forTextStyle: .caption1)
      view.textColor = .orange
      view.text = sectionError?.msg
    }
    footer.height = { 24 }
    section.footer = sectionError == nil ? nil : footer // HeaderFooterView(title: sectionError!.msg)
    reloadSection(section: section)
  }
  
  private func fetchMember() {
    HUD.show(.systemActivity)
    DatabaseManager.getMember(memberId: "cjkibyszw1m3q0186mksot14r") {
      [weak self] member, locations, error in
      guard error == nil, let member = member, let locations = locations else { return }
      RideCreator.shared.resetForMember(member: member, locations: locations)
      self?.populateRidersList()
      HUD.hide()
    }
  }

  private func addRideCreatorControllerObservers() {
    NotificationCenter.default.addObserver(
      forName: .SheprdStartDateChange,
      object: nil,
      queue: nil) { [weak self] notification in
        guard let endDateRow = self?.form.rowBy(tag: "EndDate") as? DateRow else { return }
        endDateRow.minimumDate = RideCreator.shared.startDate
        endDateRow.reload()
    }
    
    NotificationCenter.default.addObserver(
      forName: .SheprdPickupLocationChange,
      object: nil,
      queue: nil) { [weak self] _ in
        guard let row = self?.form.rowBy(tag: "PickupLocation") else { return }
        row.reload()
        let _ = row.validate()
      }
    
    NotificationCenter.default.addObserver(
      forName: .SheprdDropOffLocationChange,
      object: nil,
      queue: nil) { [weak self] _ in
        guard let row = self?.form.rowBy(tag: "DropOffLocation") else { return }
        row.reload()
        let _ = row.validate()
      }
  }
  
  private func renderForm() {
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
  
  // MARK: - Lifecycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    form.rowBy(tag: "PickupLocation")?.reload()
    form.rowBy(tag: "DropOffLocation")?.reload()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchMember()
    addRideCreatorControllerObservers()
    renderForm()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "RideCreatorToLocationSelectionSegue":
      guard let action = (sender as? ButtonRow)?.tag else { return }
      let rc = RideCreator.shared
      if action == "PickupLocation" {
        rc.locationTypeToEdit = .Pickup
      } else {
        rc.locationTypeToEdit = .DropOff
      }
    default:
      return
    }
  }
}

// MARK: - Extensions

fileprivate extension RideCreator {
  var pickupLocationLabel: String {
    if let l = pickupLocation { return l.title.primaryComponent }
    return .pickupLocationPlaceholder
  }
  
  var dropOffLocationLabel: String {
    if let l = dropOffLocation { return l.title.primaryComponent }
    return .dropoffLocationPlaceholder
  }
  
  var pickupLocationLabelColor: UIColor? {
    return pickupLocation != nil ? ThemeManager.primaryColor() : nil
  }
  
  var dropOffLocationLabelColor: UIColor? {
    return dropOffLocation != nil ? ThemeManager.secondaryColor() : nil
  }
  
  func pickupLocationValidator(_ value: String?) -> ValidationError? {
    return pickupLocation == nil ? ValidationError(msg: .noPickupLocationErrorMessage) : nil
  }
  
  func dropOffLocationValidator(_ value: String?) -> ValidationError? {
    return dropOffLocation == nil ? ValidationError(msg: .noDropOffLocationErrorMessage) : nil
  }

  func rideDatesValidator(_ value: Bool?) -> ValidationError? {
    return selectedDatesAfterExcluding.isEmpty
      ? ValidationError(msg: .noRideDateErrorMessage)
      : nil
  }
  
  func riderValidator(_ value: String?) -> ValidationError? {
    return riders.isEmpty
      ? ValidationError(msg: .noRiderErrorMessage)
      : nil
  }
}

fileprivate extension Favored {
  var explanation: String {
    switch self {
    case .Departure: return .favorDepartureExplanation
    case .Arrival: return .favorArrivalExplanation
    }
  }
  var rideTimeLabel: String {
    switch self {
    case .Departure: return .favorDepartureTimeLabel
    case .Arrival: return .favorArrivalTimeLabel
    }
  }
}

fileprivate extension FormViewController {
  func reloadSection(section: Section) {
    UIView.setAnimationsEnabled(false)
    tableView.beginUpdates()
    section.reload()
    tableView.endUpdates()
    UIView.setAnimationsEnabled(true)
  }
}

fileprivate extension String {
  var primaryComponent: String {
    return self.components(separatedBy: ",").first ?? self
  }
  static let noRideTimeErrorMessage = "Please enter the ride time"
  static let noRiderErrorMessage = "Please select at least one rider"
  static let noRideDateErrorMessage = "Please select at least on ride date"
  static let noPickupLocationErrorMessage = "Please select a pick up location"
  static let noDropOffLocationErrorMessage = "Please select a drop off location"
  static let favorDepartureExplanation = "Favoring Departure generates more accurate pickup window"
  static let favorArrivalExplanation = "Favoring Arrival generates more accurate drop off window"
  static let favorDepartureTimeLabel = "Pick Up At"
  static let favorArrivalTimeLabel = "Drop Off By"
  static let pickupLocationPlaceholder = "Select Pickup Location"
  static let dropoffLocationPlaceholder = "Select Drop Off Location"
}
