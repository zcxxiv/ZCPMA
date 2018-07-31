//
//  SelectRiderViewController.swift
//  ZCPMA
//
//  Created by ZIYUAN CHEN on 7/28/18.
//  Copyright © 2018 Sheprd. All rights reserved.
//

import UIKit
import Eureka

class RideCreatorViewController: FormViewController {
  
  private func populateRidersList() {
    let riders = ["Taylor Stubbs", "Liam Kelly", "Nick Jasset"]
    for rider in riders {
      form[0] <<< ListCheckRow<String>(rider) { listRow in
        listRow.title = rider
        listRow.selectableValue = rider
        listRow.value = rider
      }.cellSetup({ (cell, row) in
        cell.tintColor = UIColor(red: 58.0 / 255, green: 174.0 / 255, blue: 228.0 / 255, alpha: 1.0)
      })
    }
  }
  
  var rideTimeSectionFooter: String {
    return "Baog"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    form
      +++ SelectableSection<ListCheckRow<String>>("Riders", selectionType: .multipleSelection)
      
      +++ Section("Ride Locations")
        <<< ButtonRow("Burr Elementary School") {
          $0.title = $0.tag
          $0.presentationMode = .segueName(segueName: "RideCreatorToRideConfirmationSegue", onDismiss: nil)
        }
        <<< ButtonRow("West Suburban YMCA") {
          $0.title = $0.tag
          $0.presentationMode = .segueName(segueName: "RideCreatorToRideConfirmationSegue", onDismiss: nil)
        }
      
      +++ Section("Ride Dates")
        <<< SwitchRow("Recurring") {
          $0.title = $0.tag
          $0.value = false
        }.cellSetup({ (cell, row) in
          cell.switchControl.onTintColor = UIColor(red: 58.0 / 255, green: 174.0 / 255, blue: 228.0 / 255, alpha: 1.0)
        })
        <<< DateInlineRow() {
          $0.title = "Ride Date"
          $0.value = Date()
          $0.hidden = "$Recurring == true"
        }
        <<< DateInlineRow() {
          $0.title = "Start Date"
          $0.value = Date()
          $0.hidden = "$Recurring == false"
        }
        <<< DateInlineRow() {
          $0.title = "End Date"
          $0.value = Date()
          $0.hidden = "$Recurring == false"
        }
        <<< ButtonRow("Excluding Dates") {
          $0.title = $0.tag
          $0.hidden = "$Recurring == false"
          $0.presentationMode = .segueName(segueName: "ShowExcludingDaysModalSegue", onDismiss: nil)
        }
        <<< LabelRow() {
          $0.title = "Repeat On"
          $0.hidden = "$Recurring == false"
        }
        <<< WeekDayRow() {
          $0.title = "Repeat Days"
          $0.value = [.monday, .wednesday, .friday]
          $0.hidden = "$Recurring == false"
        }
      
      +++ Section(header: "Ride Times", footer: "Favoring Departure generates more accurate pickup window")
        <<< SegmentedRow<String>("Favor") {
          $0.title = "Favor          "
          $0.value = "Departure"
          $0.options = ["Departure", "Arrival"]
        }.cellSetup { cell, row in
          cell.tintColor = UIColor(red: 58.0 / 255, green: 174.0 / 255, blue: 228.0 / 255, alpha: 1.0)
        }.onChange { row in
          let section = row.section
          let footerTitle = row.value == "Departure"
            ? "Favoring Departure generates smaller pickup window"
            : "Favoring Arrival generates smaller drop-off window"
          section?.footer = HeaderFooterView(title: footerTitle)!
          section?.reload()
        }
        <<< TimeInlineRow("PickupRangeStart") {
          $0.title = "Pick Up At"
          $0.hidden = "$Favor == 'Arrival'"
        }
        <<< TimeInlineRow("DropOffRangeEnd") {
          $0.title = "Drop Off By"
          $0.hidden = "$Favor == 'Departure'"
        }

      +++ Section()
        <<< ButtonRow() { $0.title = "Next" }
          .onCellSelection { [weak self] (cell, row) in
            self?.performSegue(withIdentifier: "RideCreatorToRideConfirmationSegue", sender: nil)
          }
          .cellSetup({ (cell, _) in
            cell.tintColor = UIColor(red: 58.0 / 255, green: 174.0 / 255, blue: 228.0 / 255, alpha: 1.0);
          })
    
    populateRidersList()
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "RideCreatorToRideConfirmationSegue" {
      print("to ride creator")
    }
  }
  
}

public enum WeekDay {
  case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

public class WeekDayCell : Cell<Set<WeekDay>>, CellType {
  
  @IBOutlet var sundayButton: UIButton!
  @IBOutlet var mondayButton: UIButton!
  @IBOutlet var tuesdayButton: UIButton!
  @IBOutlet var wednesdayButton: UIButton!
  @IBOutlet var thursdayButton: UIButton!
  @IBOutlet var fridayButton: UIButton!
  @IBOutlet var saturdayButton: UIButton!
  
  open override func setup() {
    height = { 60 }
    row.title = nil
    super.setup()
    selectionStyle = .none
    for subview in contentView.subviews {
      if let button = subview as? UIButton {
        button.setImage(UIImage(named: "checkedDay"), for: .selected)
        button.setImage(UIImage(named: "uncheckedDay"), for: .normal)
        button.adjustsImageWhenHighlighted = false
        imageTopTitleBottom(button)
      }
    }
  }
  
  open override func update() {
    row.title = nil
    super.update()
    let value = row.value
    mondayButton.isSelected = value?.contains(.monday) ?? false
    tuesdayButton.isSelected = value?.contains(.tuesday) ?? false
    wednesdayButton.isSelected = value?.contains(.wednesday) ?? false
    thursdayButton.isSelected = value?.contains(.thursday) ?? false
    fridayButton.isSelected = value?.contains(.friday) ?? false
    saturdayButton.isSelected = value?.contains(.saturday) ?? false
    sundayButton.isSelected = value?.contains(.sunday) ?? false
    
    mondayButton.alpha = row.isDisabled ? 0.6 : 1.0
    tuesdayButton.alpha = mondayButton.alpha
    wednesdayButton.alpha = mondayButton.alpha
    thursdayButton.alpha = mondayButton.alpha
    fridayButton.alpha = mondayButton.alpha
    saturdayButton.alpha = mondayButton.alpha
    sundayButton.alpha = mondayButton.alpha
  }
  
  @IBAction func dayTapped(_ sender: UIButton) {
    dayTapped(sender, day: getDayFromButton(sender))
  }
  
  private func getDayFromButton(_ button: UIButton) -> WeekDay{
    switch button{
    case sundayButton:
      return .sunday
    case mondayButton:
      return .monday
    case tuesdayButton:
      return .tuesday
    case wednesdayButton:
      return .wednesday
    case thursdayButton:
      return .thursday
    case fridayButton:
      return .friday
    default:
      return .saturday
    }
  }
  
  private func dayTapped(_ button: UIButton, day: WeekDay){
    button.isSelected = !button.isSelected
    if button.isSelected{
      row.value?.insert(day)
    }
    else{
      _ = row.value?.remove(day)
    }
  }
  
  private func imageTopTitleBottom(_ button : UIButton){
    
    guard let imageSize = button.imageView?.image?.size else { return }
    let spacing : CGFloat = 3.0
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0)
    guard let titleLabel = button.titleLabel, let title = titleLabel.text else { return }
    let titleSize = title.size(withAttributes: [NSAttributedStringKey.font: titleLabel.font])
    button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0, 0, -titleSize.width)
  }
}

public final class WeekDayRow: Row<WeekDayCell>, RowType {
  required public init(tag: String?) {
    super.init(tag: tag)
    displayValueFor = nil
    cellProvider = CellProvider<WeekDayCell>(nibName: "WeekDaysCell")
  }
}
