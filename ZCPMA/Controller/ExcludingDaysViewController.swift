//
//  ExcludingDAysViewController
//  VACalendar
//
//  Created by Anton Vodolazkyi on 20.02.18.
//  Copyright © 2018 Vodolazkyi. All rights reserved.
//

import UIKit
import VACalendar

final class ExcludingDaysViewController: UIViewController {
  
  @IBOutlet weak var weekDaysView: VAWeekDaysView! {
    didSet {
      let appereance = VAWeekDaysViewAppearance(symbolsType: .short, calendar: defaultCalendar)
      weekDaysView.appearance = appereance
    }
  }
  
  let defaultCalendar: Calendar = {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone.current
    return calendar
  }()
  
  var calendarView: VACalendarView!
  
  let selectedDaysBeforeExcluding = RideCreator.shared.selectedDatesBeforeExcluding
  var excludingDates: [Date] = RideCreator.shared.excludingDates
  var selectedDates: [Date] = [] // final selected dates: selectedDatesBeforeExcluding - excludingDates

  @IBAction func done(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    let startDate = RideCreator.shared.startDate.startOfLastMonth()
    let endDate = RideCreator.shared.endDate.endOfNextMonth()
    
    let calendar = VACalendar(
      startDate: startDate,
      endDate: endDate,
      calendar: defaultCalendar
    )
    calendarView = VACalendarView(frame: .zero, calendar: calendar)
    calendarView.setAvailableDates(DaysAvailability.some(selectedDaysBeforeExcluding))
    calendarView.showDaysOut = false
    calendarView.selectionStyle = .multi
    calendarView.dayViewAppearanceDelegate = self
    calendarView.monthViewAppearanceDelegate = self
    calendarView.calendarDelegate = self
    calendarView.scrollDirection = .vertical
    calendarView.selectDates(excludingDates)
    view.addSubview(calendarView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    if calendarView.frame == .zero {
      calendarView.frame = CGRect(
        x: 0,
        y: weekDaysView.frame.maxY,
        width: view.frame.width,
        height: view.frame.height - weekDaysView.frame.maxY
      )
      calendarView.setup()
    }
  }
  
}

extension ExcludingDaysViewController: VAMonthViewAppearanceDelegate {
  
  func leftInset() -> CGFloat {
    return 10.0
  }
  
  func rightInset() -> CGFloat {
    return 10.0
  }
  
  func verticalMonthTitleFont() -> UIFont {
    return UIFont.systemFont(ofSize: 16, weight: .semibold)
  }
  
  func verticalMonthTitleColor() -> UIColor {
    return .darkText
  }
  
  func verticalCurrentMonthTitleColor() -> UIColor {
    return ThemeManager.primaryColor()
  }
  
}

extension ExcludingDaysViewController: VADayViewAppearanceDelegate {
  func textColor(for state: VADayState) -> UIColor {
    switch state {
    case .out:
      return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
    case .selected:
      return .white
    case .unavailable:
      return .lightGray
    default:
      return ThemeManager.primaryColor()
    }
  }
  
  func textBackgroundColor(for state: VADayState) -> UIColor {
    switch state {
    case .selected:
      return ThemeManager.secondaryColor()
    default:
      return .clear
    }
  }
  
  func shape() -> VADayShape {
    return .circle
  }
  
  func dotBottomVerticalOffset(for state: VADayState) -> CGFloat {
    switch state {
    case .selected:
      return 2
    default:
      return -7
    }
  }
}

extension ExcludingDaysViewController: VACalendarViewDelegate {
  func selectedDates(_ excludingDates: [Date]) {
    RideCreator.shared.excludingDates = excludingDates
  }
}

fileprivate extension Date {
  func startOfLastMonth() -> Date {
    let cal = Calendar.current
    let sometimeLastMonth = cal.date(byAdding: DateComponents(month: -1), to: self)!
    return cal.date(from: cal.dateComponents([.year, .month], from: sometimeLastMonth))!
  }
  
  func endOfNextMonth() -> Date {
    let cal = Calendar.current
    let sometimeNextMonth = cal.date(byAdding: DateComponents(month: 2, day: -1), to: self)!
    return cal.date(from: cal.dateComponents([.year, .month], from: sometimeNextMonth))!
  }
}
